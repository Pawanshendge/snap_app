class CreateAlbumSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :album_sizes do |t|
      t.integer :min_limit
      t.integer :max_limit

      t.timestamps
    end
  end
end
