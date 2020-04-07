class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      # Essential item info
      t.string :title
      t.string :quality
      t.string :description

      # Purchase info
      t.decimal :purchase_price, precision: 8, scale: 2
      t.decimal :purchase_postage_cost, precision: 8, scale: 2
      t.date :date_purchased

      # Sale info
      t.decimal :listing_price, precision: 8, scale: 2
      t.decimal :sale_price, precision: 8, scale: 2
      t.decimal :postage_cost, precision: 8, scale: 2, default: 0.0

      t.date :date_sold
      t.string :method_of_payment

      # Either in store or online
      t.string :location_of_sale

      # additional notes that can be attached to the item
      # This will be for personal notes, like special attention for the
      # item or something like that.
      t.text :notes

      t.timestamps
    end
  end
end
