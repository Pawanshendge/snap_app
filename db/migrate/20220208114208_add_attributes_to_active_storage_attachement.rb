class AddAttributesToActiveStorageAttachement < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :crop_width, :string
    add_column :active_storage_attachments, :crop_height, :string
    add_column :active_storage_attachments, :crop_x, :string
    add_column :active_storage_attachments, :crop_y, :string
  end
end
