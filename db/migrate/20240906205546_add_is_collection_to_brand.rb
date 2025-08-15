class AddIsCollectionToBrand < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :is_collection, :boolean, default: false
    add_index :brands, :is_collection
  end
end
