class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.json :data

      t.timestamps
    end
  end
end
