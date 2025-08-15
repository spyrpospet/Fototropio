class CreateOptionProductsRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :option_products_relations do |t|
      t.references :parent, null: false, foreign_key: { to_table: :options_products }
      t.references :options_product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
