class RemoveDescriptionColumnFromItems < ActiveRecord::Migration[6.0]
  def change
    Item.all.each do |item|
      val = ""
      if item.description.present?
        val = item.description + "\n"
      end
      if item.notes.present?
        val = item.notes + "\n"
      end
      if val != ""
        item.update_attribute(:notes, val)
      end
    end

    remove_column :items, :description
  end
end
