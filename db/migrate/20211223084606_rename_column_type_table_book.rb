class RenameColumnTypeTableBook < ActiveRecord::Migration[6.0]
  def change
    remove_column :table_books, :images, :attachments
    add_column :table_books, :images, :string
  end
end
