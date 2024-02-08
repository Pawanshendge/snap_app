class Addcolumntoordertransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :order_transactions, :razorpay_order_id, :string
    add_column :order_transactions, :razorpay_payment_id, :string
    add_column :order_transactions, :razorpay_signature, :string
    add_column :order_transactions, :status, :integer
  end
end
