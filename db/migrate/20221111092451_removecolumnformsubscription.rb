class Removecolumnformsubscription < ActiveRecord::Migration[6.0]
  def change
      remove_column :bx_block_custom_user_subs_subscriptions, :description
      remove_column :bx_block_custom_user_subs_subscriptions, :price
  end
end
