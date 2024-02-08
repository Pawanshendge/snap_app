class AddFieldsToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :book_color, :string
    add_column :table_books, :title_layout, :string
    add_column :table_books, :cover_type, :string
    add_column :table_books, :paper_type, :string
    add_column :table_books, :book_title, :string
    add_column :table_books, :month_range, :string
    add_column :table_books, :month_year, :string
  end
end
