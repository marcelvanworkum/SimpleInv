class RemoveDefaultFromListingPrice < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:items, :listing_price, nil)
  end
end
