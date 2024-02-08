class ChangeTypeOfColumnBookColors < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_colors, :book_color, :string
    add_column :book_colors, :book_color, :text
  end
end
