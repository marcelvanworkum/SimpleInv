class AddRemovalDateAndReasonToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :removal_date, :date, null: true
    add_column :items, :removal_reason, :string, null: true
  end
end
