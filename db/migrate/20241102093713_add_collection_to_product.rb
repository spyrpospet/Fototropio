class AddCollectionToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :collection, :string, null: true

    add_index :products, :collection
  end
end
