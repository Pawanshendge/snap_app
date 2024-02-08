FactoryBot.define do
  factory :referral_user, :class => BxBlockReferrals::ReferralUser do
    referal_count{}
    referral_code {Faker::Alphanumeric.alpha(number: 10)}
    account_id{}
    offer_id{}
    code_used{}
  end
end
