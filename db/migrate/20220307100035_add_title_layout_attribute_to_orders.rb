class AddTitleLayoutAttributeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :title_layout, :string
  end
end
