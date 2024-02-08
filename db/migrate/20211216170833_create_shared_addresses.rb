class CreateSharedAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shared_addresses do |t|
      t.string :phone_number
      t.string :full_name
      t.string :pincode
      t.string :city
      t.string :landmark
      t.string :state
      t.string :address
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
