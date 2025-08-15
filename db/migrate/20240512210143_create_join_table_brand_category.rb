class CreateJoinTableBrandCategory < ActiveRecord::Migration[7.1]
  def change
    create_join_table :brands, :categories do |t|
      t.index [:brand_id, :category_id]
      t.index [:category_id, :brand_id]
    end
  end
end
