class AddAdditionalPagesToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :additional_pages, :integer
  end
end
