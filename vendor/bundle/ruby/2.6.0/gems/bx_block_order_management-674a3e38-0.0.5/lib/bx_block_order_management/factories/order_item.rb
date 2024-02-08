FactoryBot.define do
  factory :order_item, class: 'BxBlockOrderManagement::OrderItem' do
    order { create :order }
    quantity { 1 }
    catalogue { create :catalogue }
    catalogue_variant { create :catalogue_variant }
  end
end
