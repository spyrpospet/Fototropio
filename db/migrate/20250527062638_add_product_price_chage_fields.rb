class AddProductPriceChageFields < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :price_change_from_product_code, :integer
    add_column :categories, :price_change_to_product_code, :integer
  end
end
