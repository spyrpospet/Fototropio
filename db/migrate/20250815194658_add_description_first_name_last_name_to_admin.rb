class AddDescriptionFirstNameLastNameToAdmin < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :description, :text
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
  end
end
