class CreateDeliveryCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_charges do |t|
      t.integer :charge

      t.timestamps
    end
  end
end
