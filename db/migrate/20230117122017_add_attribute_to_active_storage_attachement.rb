class AddAttributeToActiveStorageAttachement < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :show_date, :boolean, default: false
  end
end