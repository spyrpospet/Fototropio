class AddColumnLeftAndColumnRightToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :page_translations, :left_column, :text
    add_column :page_translations, :right_column, :text
  end
end
