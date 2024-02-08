class AlterBxBlockFedexIntegrationCoordinates < ActiveRecord::Migration[6.0]
  def change
    remove_column :coordinates, :delivery_id
    remove_column :coordinates, :pickup_id
    add_column :coordinates, :addressable_id, :integer
  end
end
