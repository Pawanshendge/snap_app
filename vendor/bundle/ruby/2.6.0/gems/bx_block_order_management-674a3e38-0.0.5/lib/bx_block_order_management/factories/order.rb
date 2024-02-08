FactoryBot.define do
  factory :order, class: 'BxBlockOrderManagement::Order' do
    order_number { 'OD00000001' }
    account_id { FactoryBot.create(:account).id }
    sub_total { 599 }
    total { 649.49 }
    status { 'created' }
    applied_discount { '0.0' }
    is_gift { false }
    tax_charges { '0.0' }
    is_error { false }
    #order_status_id { FactoryBot.create(:order_status).id }
    is_group { true }
    is_availability_checked { false }
    shipping_charge { '50.0' }
    shipping_discount { '50.0' }
    shipping_net_amt { '0.0' }
    shipping_total { '0.0' }
    total_tax { '50.49' }
    order_items_attributes { [] }
  end
end
