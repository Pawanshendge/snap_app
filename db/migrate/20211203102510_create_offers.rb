class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.decimal :percentage
      t.string :offername
      t.string :offercode

      t.timestamps
    end
  end
end
