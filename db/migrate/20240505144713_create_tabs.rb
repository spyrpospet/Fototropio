class CreateTabs < ActiveRecord::Migration[7.1]
  def change
    create_table :tabs do |t|
      t.references :record, null: true, polymorphic: true, index: false, type: :uuid
      t.references :product, null: false, foreign_key: true
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, null: false, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Tab.create_translation_table! :title => :string, :description => :text
      end

      dir.down do
        Tab.drop_translation_table!
      end
    end
  end
end
