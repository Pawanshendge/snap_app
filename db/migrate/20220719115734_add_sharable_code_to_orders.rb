class AddSharableCodeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :sharable_code, :string
  end
end
