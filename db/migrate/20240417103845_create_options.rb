class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.integer :sort_order, default: 0, null: false, index: true
      t.boolean :status, default: true, index: true
      t.datetime :deleted_at, null: true, index: true
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Option.create_translation_table! :title => :string
      end

      dir.down do
        Option.drop_translation_table!
      end
    end
  end
end
