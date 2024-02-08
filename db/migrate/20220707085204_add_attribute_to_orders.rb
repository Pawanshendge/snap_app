class AddAttributeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :base_price, :integer
    add_column :orders, :additional_price, :integer
  end
end
