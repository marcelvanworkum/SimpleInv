class Item < ApplicationRecord
  validates :title,
            :purchase_price,
            :purchase_postage_cost,
            :date_purchased,
            :listing_price,
            presence: true

  validates :purchase_price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :purchase_postage_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :listing_price, :numericality => { :greater_than_or_equal_to => 0 }

  validates :sale_price, :numericality => { :greater_than_or_equal_to => 0 }, :allow_blank => true
  validates :postage_cost, :numericality => { :greater_than_or_equal_to => 0 }, :allow_blank => true

  validate :valid_date?

  scope :purchased_this_month, lambda { where('date_purchased >= ?', 1.month.ago) }
  scope :purchased_this_year, lambda { where('date_purchased >= ?', 1.year.ago) }

  scope :sold_this_month, lambda { where('date_sold >= ?', 1.month.ago) }
  scope :sold_this_year, lambda { where('date_sold >= ?', 1.year.ago) }

  scope :old, lambda {
                where('date_purchased < ? AND date_sold IS NULL AND removal_date IS NULL',
                      365.days.ago) }

  def valid_date?
    return if Chronic.parse(date_purchased)
    errors.add(:date_purchased, 'is missing or invalid')
  end

  def hashcode
    to_param.upcase
  end

  def to_param
    HASH.encode(id)
  end

  def qrcode
    RQRCode::QRCode
      .new("#{hashcode}||#{title.titleize}||#{listing_price}")
      .as_svg(offset: 0,
              color: '000',
              shape_rendering: 'crispEdges',
              module_size: 6,
              standalone: true)
      .html_safe
  end

  def rubbish_data?
    is_rubbish = false
    is_rubbish |= lifetime > 2000
    is_rubbish |= lifetime.negative?
    is_rubbish |= purchase_total > 1000
    is_rubbish |= date_purchased > Time.now
    is_rubbish |= date_purchased < 10.years.ago
      
    if date_sold.present?
      is_rubbish |= date_sold > Time.now
      is_rubbish |= date_sold < 10.years.ago
      is_rubbish |= (revenue? || 0) > 1000
      is_rubbish |= (profit? || 0) > 1000
      is_rubbish |= (sale_total? || 0) > 1000
    end

    is_rubbish
  end

  def sold?
    sale_price.present?
  end

  def removed?
    removal_date.present?
  end

  def revenue?
    return nil unless sale_price.present?

    sale_total?
  end

  def profit?
    return nil unless sale_total?

    sale_total? - purchase_total
  end

  def lifetime
    unless date_sold.nil?
      return (date_sold - date_purchased).to_i
    else
      return (Date.current - date_purchased).to_i
    end
  end

  def purchase_total
    purchase_price + purchase_postage_cost
  end

  def sale_total?
    return nil unless sale_price.present?

    sale_price + (postage_cost || 0)
  end

  def sale_total_str
    sale_total?.nil? ? "-" : "$#{sale_total?}"
  end

  def profit_str
    profit?.nil? ? "-" : "$#{profit?}"
  end 

  def extra_info
    arr = []
    desc = ''
    desc += notes + "\n" if notes != '' && notes != nil

    arr << {k: 'Notes', v: desc} if desc != ''

    arr << {k: 'Quality', v: quality} if quality != ''

    arr
  end
end

