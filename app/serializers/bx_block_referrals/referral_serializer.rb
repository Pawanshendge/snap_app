module BxBlockReferrals
  class ReferralSerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :referral_code,
      :referral_by,
      :referal_count,
      :code_used,
      :account_id,
      :offer_id
    ]
  end
end