class AddBarcodedToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :barcoded, :boolean, null: false, :default => false
  end
end
