class RemoveUnusedColumnsFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :size
    remove_column :items, :colour
    remove_column :items, :designer
    remove_column :items, :made_in
    remove_column :items, :fabric_composition
    remove_column :items, :layby_item
    remove_column :items, :exchanged
  end
end
