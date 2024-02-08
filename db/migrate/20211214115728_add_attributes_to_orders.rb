class AddAttributesToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :no_of_pages, :integer
    add_column :orders, :book_size, :string
    add_column :orders, :book_title, :string
    add_column :orders, :book_color, :string
    add_column :orders, :cover_type, :string
    add_column :orders, :paper_type, :string
    add_column :orders, :book_id, :integer
  end
end

