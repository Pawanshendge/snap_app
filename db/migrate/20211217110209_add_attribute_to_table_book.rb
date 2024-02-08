class AddAttributeToTableBook < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :images, :attachments
  end
end
