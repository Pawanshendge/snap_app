class RemoveIndexFromOrderItemTable < ActiveRecord::Migration[6.0]
  def change
    remove_index :order_items, :catalogue_id
    remove_index :order_items, :catalogue_variant_id
    change_column_null :order_items, :catalogue_id, true
    change_column_null :order_items, :catalogue_variant_id, true
  end
end
