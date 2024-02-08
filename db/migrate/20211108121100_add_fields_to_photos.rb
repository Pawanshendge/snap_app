class AddFieldsToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :title, :string
    add_column :photos, :month_range, :string
    add_column :photos, :month_year, :string
    add_column :photos, :image_caption, :string
  end
end
