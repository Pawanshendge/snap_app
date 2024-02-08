require 'rails_helper'

RSpec.describe BxBlockOrderManagement::DeliveryAddressOrder, type: :model do
  context "association test" do
    it "should belongs_to order " do
      t = BxBlockOrderManagement::DeliveryAddressOrder.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to delivery_address " do
      t = BxBlockOrderManagement::DeliveryAddressOrder.reflect_on_association(:delivery_address)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end 