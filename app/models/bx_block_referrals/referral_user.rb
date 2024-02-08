module BxBlockReferrals
  class ReferralUser < ApplicationRecord
    self.table_name = :referral_user

    belongs_to :accounts, class_name: 'AccountBlock::Account'

  end
end

