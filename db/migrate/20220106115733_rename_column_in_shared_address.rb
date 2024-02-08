class RenameColumnInSharedAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :shared_addresses, :address, :string
    add_column :shared_addresses, :address1, :string
  end
end
