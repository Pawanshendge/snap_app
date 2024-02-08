class AddSpineTitleToTableBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :spine_title, :text
  end
end
