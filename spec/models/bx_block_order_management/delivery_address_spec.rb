require 'rails_helper'

RSpec.describe BxBlockOrderManagement::DeliveryAddress, type: :model do
  context "association test" do
    it "should has_many delivery_address_orders " do
      t = BxBlockOrderManagement::DeliveryAddress.reflect_on_association(:delivery_address_orders)
      expect(t.macro).to eq(:has_many)
    end       
    it "should has_many orders " do
      t = BxBlockOrderManagement::DeliveryAddress.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end     
    it "should belongs_to account " do
      t = BxBlockOrderManagement::DeliveryAddress.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end   
    it { should validate_presence_of(:name) }  
    it { should validate_presence_of(:flat_no) }  
    it { should validate_presence_of(:address) }  
    it { should validate_presence_of(:zip_code) }  
    it { should validate_presence_of(:phone_number) }  
    it { should validate_presence_of(:address_for) }  
  end
end