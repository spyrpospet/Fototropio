class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.boolean :status, default: true
      t.integer :sort_order, default: 0

      t.timestamps
    end
    add_index :posts, :status
    add_index :posts, :sort_order

    reversible do |dir|
      dir.up do
        Post.create_translation_table! :title => :string, :description => :text, :meta_title => :string, :meta_description => :text, :slug => :text
      end

      dir.down do
        Post.drop_translation_table!
      end
    end
  end
end
