class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.references :record, null: true, polymorphic: true, index: false, type: :uuid
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, index: true
      t.datetime :deleted_at, null: true, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Brand.create_translation_table! :title => :string, :description => :text, :meta_title => :string, :meta_description => :text, :slug => :text
      end

      dir.down do
        Brand.drop_translation_table!
      end
    end
  end
end
