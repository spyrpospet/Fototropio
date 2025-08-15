class AddAncestryToBrand < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :ancestry, :string
    add_index :brands, :ancestry
  end
end
