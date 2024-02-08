class AddNewColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :shared_link, :string
  end
end
