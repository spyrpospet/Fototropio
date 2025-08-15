class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.boolean :status, default: true
      t.integer :sort_order, default: 0, null: false

      t.timestamps
    end
    add_index :projects, :status
    add_index :projects, :sort_order

    reversible do |dir|
      dir.up do
        Project.create_translation_table! :title => :string, :description => :text, :slug => :text
      end

      dir.down do
        Project.drop_translation_table!
      end
    end
  end
end
