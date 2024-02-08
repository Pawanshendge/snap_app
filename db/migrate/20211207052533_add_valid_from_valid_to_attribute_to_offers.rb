class AddValidFromValidToAttributeToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :offer_start_date, :datetime
    add_column :offers, :offer_end_date, :datetime
  end
end
