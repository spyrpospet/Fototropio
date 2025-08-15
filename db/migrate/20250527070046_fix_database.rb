class FixDatabase < ActiveRecord::Migration[7.1]
  def change
    # Remove columns from products table if they exist
    if column_exists?(:products, :price_change_from_product_code)
      remove_column :products, :price_change_from_product_code
    end
    
    if column_exists?(:products, :price_change_to_product_code)
      remove_column :products, :price_change_to_product_code
    end
    
    # Add columns to categories table if they don't exist
    unless column_exists?(:categories, :price_change_from_product_code)
      add_column :categories, :price_change_from_product_code, :integer
    end
    
    unless column_exists?(:categories, :price_change_to_product_code)
      add_column :categories, :price_change_to_product_code, :integer
    end
  end
end