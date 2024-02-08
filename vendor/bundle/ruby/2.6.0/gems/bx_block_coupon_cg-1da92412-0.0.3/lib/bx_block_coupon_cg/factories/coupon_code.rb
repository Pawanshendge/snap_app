FactoryBot.define do
  factory :coupon_code, :class => 'BxBlockCouponCg::CouponCode' do
    title { 'CCG-1' }
    description { 'Coupon code genrator 1' }
    code { 'Code' }
    discount_type { 'flat' }
    discount { 10.5 }
    valid_from { Time.now }
    valid_to { Time.now + 5.days }
    min_cart_value { 1 }
    max_cart_value { 200 }
  end
end
