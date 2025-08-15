class CreateOptionsProductsItems < ActiveRecord::Migration[7.1]
  def change
    create_table :options_products_items do |t|
      t.references :options_product, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :sort_order, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
