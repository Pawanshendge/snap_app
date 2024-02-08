class AddColumnToActiveStorageAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :title, :string
    add_column :active_storage_attachments, :photo_type, :string
  end
end
