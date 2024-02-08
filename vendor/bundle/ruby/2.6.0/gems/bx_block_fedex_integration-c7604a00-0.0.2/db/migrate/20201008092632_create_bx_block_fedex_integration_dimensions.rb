class CreateBxBlockFedexIntegrationDimensions < ActiveRecord::Migration[6.0]
  def change
    create_table :dimensions do |t|
      t.references :item, null: false, foreign_key: true
      t.float :height
      t.float :length
      t.float :width

      t.timestamps
    end
  end
end
