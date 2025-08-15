class AddHandleToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :handle, :string, null: true

    add_index :pages, :handle
  end
end
