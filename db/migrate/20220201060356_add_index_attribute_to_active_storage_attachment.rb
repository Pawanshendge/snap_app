class AddIndexAttributeToActiveStorageAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :width, :string
    add_column :active_storage_attachments, :height, :string
    add_column :active_storage_attachments, :index, :integer
  end
end
