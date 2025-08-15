class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.string :handle, null: true, index: true
      t.boolean :can_buy, default: false, null: false, index: true
      t.integer :sort_order, default: 0, null: false, index: true
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Availability.create_translation_table! :title => :string
      end

      dir.down do
        Availability.drop_translation_table!
      end
    end
  end
end
