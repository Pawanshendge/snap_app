class AddFieldsToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :active, :boolean, default: false
    add_column :offers, :max_limit, :decimal
    add_column :offers, :valid_for, :decimal
  end
end
