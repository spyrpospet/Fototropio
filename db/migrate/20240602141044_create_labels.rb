class CreateLabels < ActiveRecord::Migration[7.1]
  def change
    create_table :labels do |t|
      t.boolean :status, default: true, index: true
      t.integer :sort_order

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Label.create_translation_table! :title => :string
      end

      dir.down do
        Label.drop_translation_table!
      end
    end
  end
end
