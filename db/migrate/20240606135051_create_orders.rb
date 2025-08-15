class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.json :data, null: true
      t.integer :status, default: 0
      t.integer :sort_order, default: 0

      t.timestamps
    end
    add_index :orders, :status
    add_index :orders, :sort_order
  end
end
