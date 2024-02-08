class AddReferralCode < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :referral_code, :string
    add_column :accounts, :referred_by, :string
  end
end
