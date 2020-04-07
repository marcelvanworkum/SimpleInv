module ItemSearchType
  ALL = 'All'
  SOLD = 'Sold'
  UNSOLD = 'Unsold'
  REMOVED = 'Removed'
  AGE = 'Age'
  UNBARCODED = 'Unbarcoded'
  RUBBISH = 'Rubbish Data'
end

module ItemSearchOrder
  DESC = 'Descending'
  ASC = 'Ascending'
end

class ItemsController < ApplicationController
  require 'will_paginate/array'

  before_action :set_item, only: [:show, :edit, :update, :destroy, :sell, :remove, :barcode]

  def index
    @search_orders = [ItemSearchOrder::DESC, ItemSearchOrder::ASC]
    @search_types = [
      ItemSearchType::ALL,
      ItemSearchType::SOLD,
      ItemSearchType::UNSOLD,
      ItemSearchType::REMOVED,
      ItemSearchType::AGE,
      ItemSearchType::UNBARCODED,
      ItemSearchType::RUBBISH
    ]

    @current_search_type = params[:search_type] || @search_types.first
    @current_search_order = params[:search_order] || @search_orders.first

    if params[:search_phrase]
      @items = Item.where('LOWER(title) like ?', "%#{params[:search_phrase]}%")
    elsif params[:search_type]
      sort_str = @current_search_order == ItemSearchOrder::DESC ? 'DESC' : 'ASC'

      case params[:search_type]
      when ItemSearchType::ALL
        @items = Item.all.order("created_at #{sort_str}")
      when ItemSearchType::SOLD
        @items = Item.where.not(sale_price: nil).order("date_sold #{sort_str}")
      when ItemSearchType::UNSOLD
        @items = Item.where(sale_price: nil).order("date_purchased #{sort_str}")
      when ItemSearchType::REMOVED
        @items = Item.where.not(removal_date: nil).order("removal_date #{sort_str}")
      when ItemSearchType::AGE
        @items = Item.all.sort_by(&:lifetime)
        if sort_str == 'DESC'
          @items.reverse!
        end
      when ItemSearchType::UNBARCODED
        @items = Item.where(barcoded: false).order("created_at #{sort_str}")
      when ItemSearchType::RUBBISH
        @items = Item.select { |i| i.rubbish_data? }
      else
        @items = []
      end

      if params[:search_type] != ItemSearchType::REMOVED || params[:search_type] != ItemSearchType::ALL
        @items = @items.select { |item| not item.removed? }
      end
    else 
      @items = Item.all.order('created_at DESC')
    end

    @items = @items.paginate page: params[:page], per_page: 50
  end

  def show; end

  def new
    @item = Item.new
  end

  def print
    @items = Item.where(barcoded: false)
    respond_to do |f|
      f.pdf do
        render(pdf: 'barcodes', template: 'items/print.html.erb', layout: 'pdf.html')
      end
    end
  end

  def search
    unless params[:search_phrase]
      flash[:error] = 'Searched with incorrect params'
      redirect_to root_path
    end

    phrase = params[:search_phrase].downcase

    begin
      maybe_hash = HASH.decode(phrase)
      # A non-barcode search phrase was entered, so just search for the text
      if maybe_hash.empty?
        redirect_to items_path(params: { search_phrase: phrase })
      else
        item = Item.find(maybe_hash).first
        redirect_to action: "show", id: item.hashcode
      end
    rescue => exception
      flash[:error] = exception.message
      redirect_to root_path
    end
  end

  def sell; end

  def barcode
    @item.update_attribute(:barcoded, true)
    redirect_to request.referrer
  end

  def remove
    render :remove
  end

  def stats
    @unsold_items = Item.where(date_sold: nil, removal_date: nil)
    @sold_items = Item.where.not(date_sold: nil)

    @revenue = Item.sold_this_year.group_by_week(:date_sold)
                   .sum('sale_price + postage_cost')
    @profit = Item.sold_this_year.group_by_week(:date_sold)
                  .sum('sale_price + postage_cost - purchase_price - purchase_postage_cost')
  end

  def edit; end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = 'The Item was added!'
      redirect_to @item
    else
      flash[:error] = 'Failed to create Item'
      render :new
    end
  end

  def update
    if @item.update(item_params)
      flash[:success] = 'Item was successfully updated'
      redirect_to @item
    else
      flash[:error] = 'Failed to update Item'
      render :edit
    end
  end

  def destroy
    begin
      @item.destroy
      flash[:success] = 'Your item was deleted successfully.'
    rescue => exception
      flash[:error] = exception.message
    end
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(HASH.decode(params[:id].downcase).first)
  end

  def item_params
    params
      .require(:item)
      .permit(
            :title, :purchase_price, :purchase_postage_cost, :date_purchased,
            # Optional Info
            :notes, :quality,
            # Sale Info
            :sale_price, :listing_price, :postage_cost, :date_sold, 
            :method_of_payment, :location_of_sale,
            # Removal Info
            :removal_date, :removal_reason)
  end
end
