class AddTitleColorAndLogoColor < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :title_color, :string
    add_column :table_books, :logo_color, :string
  end
end
