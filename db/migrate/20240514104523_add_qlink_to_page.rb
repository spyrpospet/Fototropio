class AddQlinkToPage < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :qlink, :boolean, default: false

    add_index :pages, :qlink
  end
end
