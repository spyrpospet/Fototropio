class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :record, null: true, polymorphic: true, index: false, type: :uuid
      t.references :availability, null: false, foreign_key: true
      t.references :brand, null: true, foreign_key: true
      t.json :data
      t.string :code, null: false, index: true
      t.string :sku
      t.string :mpn
      t.decimal :price, precision: 10, scale: 2, null: false, index: true
      t.decimal :offer, precision: 10, scale: 2, null: true, index: true
      t.integer :quantity, default: 1, null: false, index: true
      t.boolean :subtract, default: false
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, index: true
      t.datetime :deleted_at, null: true, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Product.create_translation_table! :title => :string, :description => :text, :meta_title => :string, :meta_description => :text, :slug => :text
      end

      dir.down do
        Product.drop_translation_table!
      end
    end
  end
end
