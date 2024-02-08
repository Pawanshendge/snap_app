FactoryBot.define do
  factory :delivery_address, class: 'BxBlockOrderManagement::DeliveryAddress' do
    account { create :email_account }
    address { 'Address details' }
    address_line_2 { 'More address details' }
    address_type { 'Address type' }
    address_for { 'shipping' }
    name { 'Address name' }
    flat_no { '1' }
    zip_code { '1234' }
    phone_number { '+150379260133' }
    latitude { 1 }
    longitude { 1 }
    residential { true }
    city { 'City name' }
    state_code { '123' }
    country_code { '12' }
    state { 'State name' }
    country { 'Country name' }
    is_default { true }
    landmark { 'A place' }
  end
end
