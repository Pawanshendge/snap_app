class CreateBxBlockFedexIntegrationShipmentValues < ActiveRecord::Migration[6.0]
  def change
    create_table :shipment_values do |t|
      t.references :shipment, null: false, foreign_key: true
      t.float :amount
      t.string :currency

      t.timestamps
    end
  end
end
