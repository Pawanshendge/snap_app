FactoryBot.define do
  factory :coupon, :class => 'BxBlockCoupons::Coupon' do
    name { 'save_500' }
    discount { 50 }
    coupon_type { 0 }
    min_order { 2000 }
    status { 'activated' }
    max_discount { 500 }
  end
end
