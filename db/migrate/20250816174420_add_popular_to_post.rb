class AddPopularToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :popular, :boolean, default: false
    add_index :posts, :popular
  end
end
