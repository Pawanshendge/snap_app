class AddUserLinkAttributeToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :user_link, :string
  end
end
