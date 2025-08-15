class CreateBanners < ActiveRecord::Migration[7.1]
  def change
    create_table :banners do |t|
      t.string :url, null: true
      t.string :position, null: true
      t.boolean :status, default: true, index: true
      t.integer :sort_order, default: 0, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Banner.create_translation_table! :title => :string, :sub_title => :text
      end

      dir.down do
        Banner.drop_translation_table!
      end
    end
  end
end
