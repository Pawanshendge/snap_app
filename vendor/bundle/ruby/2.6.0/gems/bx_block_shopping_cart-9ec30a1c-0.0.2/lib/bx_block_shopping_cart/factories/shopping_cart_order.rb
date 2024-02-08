FactoryBot.define do
  factory :shopping_cart_order, :class => 'BxBlockShoppingCart::Order' do
    service_provider { create :email_account }
    customer { create :email_account }
    booking_date { Date.today }
    slot_start_time { '12:00 PM' }
    total_fees { 120 }
    instructions { 'Loved your work' }
    service_total_time_minutes { 30 }
    is_coupon_applied { false }
    address { create :address }
    order_type { 'instant booking' }
  end
end
