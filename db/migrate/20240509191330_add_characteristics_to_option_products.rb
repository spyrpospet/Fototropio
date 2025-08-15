class AddCharacteristicsToOptionProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :options_products, :characteristic, :boolean, default: false

    add_index :options_products, :characteristic
  end
end
