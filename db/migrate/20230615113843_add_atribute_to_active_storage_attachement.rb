class AddAtributeToActiveStorageAttachement < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_attachments, :face_position, :string
  end
end
