class CreateBxBlockReferralsReferralUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :referral_user do |t|
      t.integer :referal_count
      t.string :referral_by
      t.string :referral_code
      t.integer :account_id
      t.integer :offer_id
      t.integer :code_used

      t.timestamps
    end
  end
end
