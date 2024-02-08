class AddFieldToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :used_discount_code, :string
  end
end
