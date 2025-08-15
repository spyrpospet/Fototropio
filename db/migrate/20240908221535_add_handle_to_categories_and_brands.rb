class AddHandleToCategoriesAndBrands < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :handle, :string, null: true
    add_index :brands, :handle
  end
end
