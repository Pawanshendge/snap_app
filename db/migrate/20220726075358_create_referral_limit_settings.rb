class CreateReferralLimitSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :referral_limit_settings do |t|
      t.integer :max_user_refers
      t.integer :max_order_refers
      t.boolean :active

      t.timestamps
    end
  end
end
