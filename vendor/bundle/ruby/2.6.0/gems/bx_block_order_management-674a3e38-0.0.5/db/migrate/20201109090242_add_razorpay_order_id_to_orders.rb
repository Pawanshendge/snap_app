class AddRazorpayOrderIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :razorpay_order_id, :string
  end
end
