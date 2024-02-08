FactoryBot.define do
  factory :terms_and_condition, class: "BxBlockPrivacySettings::TermsAndConditions" do
    offer { "offer" }
    valid_till { "20/nov/3070" } 
    code {78945} 
    applied {"applied" }
    coupon_type { "story" }
  end
end