class AddBestSellerToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :best_seller, :boolean, default: false

    add_index :products, :best_seller
  end
end
