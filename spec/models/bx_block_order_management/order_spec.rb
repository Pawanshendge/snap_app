require 'rails_helper'

RSpec.describe BxBlockOrderManagement::Order, type: :model do
  context "association test" do
    it "should belongs_to order_status " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:order_status)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to coupon_code " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:coupon_code)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_one order_transaction " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:order_transaction)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_many order_items " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many catalogues " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:catalogues)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_one address " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:address)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_many order_trackings " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:order_trackings)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many trackings " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:trackings)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many delivery_address_orders " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:delivery_address_orders)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many delivery_addresses " do
      t = BxBlockOrderManagement::Order.reflect_on_association(:delivery_addresses)
      expect(t.macro).to eq(:has_many)
    end   
    it { should validate_presence_of(:status) }  
    it{ should accept_nested_attributes_for :order_items }         
    it { is_expected.to callback(:set_status).before(:save) }
    it { is_expected.to callback(:add_order_number).before(:create) }
    it { is_expected.to callback(:send_order_draft_mail).after(:create) } 
  end
end