class AddColumToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :phone_number, :bigint
    add_column :offers, :email, :string
  end
end
