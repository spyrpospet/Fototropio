class CreateTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :types do |t|
      t.string :handle, null: false, index: true
      t.string :group, null: false, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Type.create_translation_table! :title => :string
      end

      dir.down do
        Type.drop_translation_table!
      end
    end
  end
end
