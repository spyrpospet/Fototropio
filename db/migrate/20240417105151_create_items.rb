class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :option, null: false, foreign_key: true, index: true
      t.integer :sort_order, default: 0, null: false, index: true
      t.datetime :deleted_at, null: true, index: true
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Item.create_translation_table! :title => :string
      end

      dir.down do
        Item.drop_translation_table!
      end
    end
  end
end
