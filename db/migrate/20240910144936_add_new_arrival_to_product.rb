class AddNewArrivalToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :new_arrival, :boolean, default: false

    add_index :products, :new_arrival
  end
end
