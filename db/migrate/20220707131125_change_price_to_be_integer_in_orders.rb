class ChangePriceToBeIntegerInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :additional_price, :decimal
    change_column :orders, :base_price, :decimal
  end
end
