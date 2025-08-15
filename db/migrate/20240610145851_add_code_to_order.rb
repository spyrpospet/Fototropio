class AddCodeToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :code, :string, null: false
    add_index :orders, :code
  end
end
