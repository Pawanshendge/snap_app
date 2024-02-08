class AddAttributesToOrdersTable < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :length, :string
    add_column :orders, :breadth, :string
    add_column :orders, :height, :string
    add_column :orders, :weight, :string
    add_column :orders, :ship_rocket_order_id, :string
    add_column :orders, :ship_rocket_shipment_id, :string
    add_column :orders, :ship_rocket_status, :string
    add_column :orders, :ship_rocket_status_code, :string
    add_column :orders, :ship_rocket_onboarding_completed_now, :string
    add_column :orders, :ship_rocket_awb_code, :string
    add_column :orders, :ship_rocket_courier_company_id, :string
    add_column :orders, :ship_rocket_courier_name, :string
    add_column :orders, :logistics_ship_rocket_enabled, :boolean, default: false
  end
end
