FactoryBot.define do
  factory :order, class: "BxBlockOrderManagement::Order" do
    order_number{}
    account_id{}
    coupon_code_id{}
    sub_total{ 600 }
    status{ "draft" }
    applied_discount{}
    delivery_charges{}
    amount{ 600 }
    cover_type{ "soft cover" }
    total{}
    additional_price{}
    base_price{}
    no_of_pages{}
    sharable_code {Faker::Alphanumeric.alpha(number: 10)}
  end

  factory :price, class: "BxBlockBook::Price" do
    max_limit{ 20 }
    min_limit{ 10 }
    price{ 1000 }
    book_size{ 8*8 }
    cover_type{ "soft cover" }
  end

  factory :delivery, class: "BxBlockBook::DeliveryCharge" do
   charge { 100 }
  end

  factory :additional_price, class: "BxBlockBook::AdditionalPricePerPage" do
   additional_price { 100 }
  end

  factory :offers ,class: "BxBlockDiscountsoffers::Offer" do
    # code {"tc02"}
    min_cart_value {500}
    discount {20}
    title {"abc"}
    description {"abcd"}
    discount_type {"percentage"}
    valid_from {"28 Nov 2022"}
    valid_to {"17 Sep 2023"}
    max_limit {100}
    # coupon_type {"normal"}
  end

  factory :shared_offers ,class: "BxBlockDiscountsoffers::Offer" do
    # code {"tc02"}
    min_cart_value {500}
    discount {20}
    title {"abc"}
    description {"abcd"}
    discount_type {"percentage"}
    valid_from {"28 Nov 2022"}
    valid_to {"17 Sep 2023"}
    max_limit {100}
    # coupon_type {"normal"}
    # code {Faker::Alphanumeric.alpha(number: 10)}
  end

end
