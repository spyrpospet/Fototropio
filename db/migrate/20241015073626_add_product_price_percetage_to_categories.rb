class AddProductPricePercetageToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :product_price_percentage, :integer
    add_index :categories, :product_price_percentage
  end
end
