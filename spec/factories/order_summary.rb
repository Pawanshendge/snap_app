FactoryBot.define do
  factory :order_summary, class: "BxBlockOrdersummary::OrderSummary" do
    quantity{}
    gift_note{}
    discount_code{}
    order_subtotal{}
    book_id{}
    delivery_charge{}
    book_size{}
    cover_type{}
    order_total{}
    order_id{}
  end
end