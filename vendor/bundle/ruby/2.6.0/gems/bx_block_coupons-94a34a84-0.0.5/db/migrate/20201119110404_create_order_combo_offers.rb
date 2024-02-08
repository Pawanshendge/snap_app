class CreateOrderComboOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :order_combo_offers do |t|
      t.bigint :order_id
      t.bigint :combo_offer_id
    end
  end
end
