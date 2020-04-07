class ChangeListingPrice < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :listing_price, :decimal, :default => 0, :null => false
  end
end
