class CreateUserOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_offers do |t|
      t.bigint :account_id
      t.bigint :offer_id
      t.integer :use_count, :null => false, :default => 0
      t.string :code
      t.boolean :applied, :null => false, :default => false

      t.timestamps
    end
  end
end
