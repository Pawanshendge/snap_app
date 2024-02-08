class Addcolumntosubscription < ActiveRecord::Migration[6.0]
  def change
      remove_column :bx_block_custom_user_subs_subscriptions, :status
      add_column :bx_block_custom_user_subs_subscriptions, :active, :boolean, default: false
  end
end