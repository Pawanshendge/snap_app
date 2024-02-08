class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :year
      t.string :month

      t.timestamps
    end
  end
end
