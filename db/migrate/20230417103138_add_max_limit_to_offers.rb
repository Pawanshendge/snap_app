class AddMaxLimitToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :max_capping_limit, :integer
  end
end
