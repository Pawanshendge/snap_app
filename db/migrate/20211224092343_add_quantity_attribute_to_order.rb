class AddQuantityAttributeToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :quantity, :integer, default: 1
    add_column :orders, :gift_note, :string
  end
end
