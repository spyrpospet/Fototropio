class AddPositionToActiveStorageAttachment < ActiveRecord::Migration[7.1]
  def change
    add_column :active_storage_attachments, :position, :integer, default: 0
    add_index :active_storage_attachments, :position
  end
end
