class AddColumnToAboutUs < ActiveRecord::Migration[6.0]
  def change
     add_column :table_books, :description, :text
  end
end
