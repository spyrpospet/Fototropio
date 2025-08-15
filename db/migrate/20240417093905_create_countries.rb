class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :title
      t.boolean :default, default: false, index: true
      t.integer :sort_order, default: 0, null: false, index: true
      t.datetime :deleted_at, null: true, index: true

      t.timestamps
    end
  end
end
