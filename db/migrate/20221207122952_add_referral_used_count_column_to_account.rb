class AddReferralUsedCountColumnToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :referral_used, :integer
  end
end
