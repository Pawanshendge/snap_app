class Addcolumnstosubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_custom_user_subs_subscriptions, :status, :string
    add_column :bx_block_custom_user_subs_subscriptions, :details, :text
    add_column :bx_block_custom_user_subs_subscriptions, :book_original_price, :decimal
    add_column :bx_block_custom_user_subs_subscriptions, :no_of_books, :integer
    add_column :bx_block_custom_user_subs_subscriptions, :gift_included, :string
    add_column :bx_block_custom_user_subs_subscriptions, :total_amount, :decimal
    add_column :bx_block_custom_user_subs_subscriptions, :subscription_package_amount, :decimal
  end
end
