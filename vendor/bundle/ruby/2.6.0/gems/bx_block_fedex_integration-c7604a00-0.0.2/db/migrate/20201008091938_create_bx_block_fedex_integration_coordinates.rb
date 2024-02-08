class CreateBxBlockFedexIntegrationCoordinates < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinates do |t|
      t.references :delivery, null: true, foreign_key: true
      t.references :pickup, null: true, foreign_key: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
