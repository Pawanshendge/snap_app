class CreateContributionImages < ActiveRecord::Migration[6.0]
  def change
    create_table :contribution_images do |t|
      t.boolean :is_deleted
      t.integer :contribution_id
      t.string :service_url
      t.integer :image_id

      t.timestamps
    end
  end
end
