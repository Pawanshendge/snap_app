class AddAttributesToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :email_address, :string
    add_column :addresses, :phone_number, :string
    add_column :addresses, :full_name, :string
    add_column :addresses, :pincode, :string
    add_column :addresses, :city, :string
    add_column :addresses, :landmark, :string
    add_column :addresses, :state, :string
  end
end
