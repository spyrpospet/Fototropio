class AddLabelToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :label, null: true, foreign_key: true
  end
end
