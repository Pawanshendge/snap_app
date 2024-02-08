FactoryBot.define do
  factory :user_offers, class: "BxBlockDiscountsoffers::UserOffer" do
   code {"content"}
   applied {"applied"}
   use_count {'2'}
   coupon_type {"normal"}
  end
end
