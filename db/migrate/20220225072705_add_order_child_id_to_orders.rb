class AddOrderChildIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_child_id, :integer
  end
end
