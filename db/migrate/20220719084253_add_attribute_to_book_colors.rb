class AddAttributeToBookColors < ActiveRecord::Migration[6.0]
  def change
    add_column :book_colors, :logo_color, :text
    add_column :book_colors, :title_color, :text
  end
end
