class CreateRegions < ActiveRecord::Migration[7.1]
  def change
    create_table :regions do |t|
      t.references :country, null: false, foreign_key: true
      t.string :title
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, null: false, index: true
      t.datetime :deleted_at, null: true, index: true

      t.timestamps
    end
  end
end
