class AddBookUrlToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :book_url, :string
  end
end
