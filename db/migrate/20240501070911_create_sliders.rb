class CreateSliders < ActiveRecord::Migration[7.1]
  def change
    create_table :sliders do |t|
      t.text :url, null: true
      t.text :alt_title, null: true
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, index: true

      t.timestamps
    end
  end
end
