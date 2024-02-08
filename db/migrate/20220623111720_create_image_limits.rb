class CreateImageLimits < ActiveRecord::Migration[6.0]
  def change
    create_table :image_limits do |t|
      t.integer :min_images
      t.integer :max_images
      t.integer :img_resolution
    end
  end
end
