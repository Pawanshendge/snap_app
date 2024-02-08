class AddAccountIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :account_id, :integer
  end
end
