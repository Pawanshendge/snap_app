class AddAttibuteToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :is_deleted, :boolean, default: false 
  end
end
