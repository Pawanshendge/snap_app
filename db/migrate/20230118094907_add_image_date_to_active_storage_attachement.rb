class AddImageDateToActiveStorageAttachement < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :image_date, :string
  end
end
