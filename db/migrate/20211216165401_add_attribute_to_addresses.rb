class AddAttributeToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :share_with_family_member, :boolean, default: false
  end
end
