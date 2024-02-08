class AddAttibuteToOffers < ActiveRecord::Migration[6.0]
  def change
  	add_column :offers, :combine_with_other_offer, :integer
    add_column :offers, :extra_discount, :decimal
    add_column :offers, :full_phone_number, :string
  end
end
