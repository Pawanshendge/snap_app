class AddFieldToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :photo_type, :string
  end
end
