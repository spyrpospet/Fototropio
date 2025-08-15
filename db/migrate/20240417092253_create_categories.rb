class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :record, null: true, polymorphic: true, index: false, type: :uuid
      t.boolean :menu, default: false, index: true
      t.string :handle, null: true, index: true
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, null: false, index: true
      t.datetime :deleted_at, null: true, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Category.create_translation_table! :title => :string, :description => :text, :meta_title => :string, :meta_description => :text, :slug => :text
      end

      dir.down do
        Category.drop_translation_table!
      end
    end
  end
end
