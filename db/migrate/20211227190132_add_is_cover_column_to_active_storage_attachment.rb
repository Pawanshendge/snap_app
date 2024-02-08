class AddIsCoverColumnToActiveStorageAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :is_cover, :boolean, default: false
    add_column :active_storage_attachments, :image_caption, :string
    rename_column :active_storage_attachments, :photo_type, :image_type
  end
end
