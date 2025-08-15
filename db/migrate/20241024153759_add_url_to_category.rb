class AddUrlToCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :url, :string, null: true
    add_column :categories, :url_title, :string, null: true
  end
end
