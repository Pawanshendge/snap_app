class AddColumnsToTableBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :to_month, :string
    add_column :table_books, :to_year, :integer
    add_column :table_books, :from_month, :string
    add_column :table_books, :from_year, :integer
  end
end
