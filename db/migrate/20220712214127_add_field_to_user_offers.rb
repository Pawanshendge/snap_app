class AddFieldToUserOffers < ActiveRecord::Migration[6.0]
  def change
    remove_column :offers, :valid_for, :decimal

    add_column :offers, :coupon_type, :integer
    add_column :offers, :valid_for, :integer
    add_column :user_offers, :coupon_type, :integer
  end
end
