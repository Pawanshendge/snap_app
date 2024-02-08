class MoveDescriptionToAboutUs < ActiveRecord::Migration[6.0]
  def change
    remove_column :table_books, :description, :text
    add_column :about_us, :description, :text
  end
end
