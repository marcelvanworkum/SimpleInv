class ChangeItemDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :method_of_payment, :string, :default => "Eftpos", :null => false
    change_column :items, :location_of_sale, :string, :default => "Other", :null => false
  end
end
