class AddAttributeToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :title, :string
    add_column :offers, :description, :string
    add_column :offers, :code, :string
    add_column :offers, :min_cart_value, :decimal
    add_column :offers, :discount, :decimal
    add_column :offers, :discount_type, :string, default: "flat"
    rename_column :offers, :offer_start_date, :valid_from
    rename_column :offers, :offer_end_date, :valid_to
    remove_column :offers, :offername, :string
    remove_column :offers, :offercode, :string
    remove_column :offers, :percentage, :decimal
  end
end
