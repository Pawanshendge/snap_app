require 'rails_helper'

RSpec.describe BxBlockShoppingCart::Order, type: :model do
  context "association test" do
    it "should belongs_to address " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:address)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to service_provider " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:service_provider)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to customer " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:customer)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to coupon " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:coupon)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_one booked_slot " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:booked_slot)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_and_belongs_to_many sub_categories " do
      t = BxBlockShoppingCart::Order.reflect_on_association(:sub_categories)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end  
    it { should validate_presence_of(:booking_date) }
    it { should validate_presence_of(:slot_start_time) }    
    it { should validate_presence_of(:total_fees) }
    it { should validate_presence_of(:order_type) }
    it { is_expected.to callback(:check_coupon_detail).before(:save) }
    it { is_expected.to callback(:occupy_time_slot).after(:create) }
    it{ should accept_nested_attributes_for :sub_categories }  
  end 
end 