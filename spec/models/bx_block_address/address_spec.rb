require 'rails_helper'

RSpec.describe BxBlockAddress::Address, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockAddress::Address.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to order " do
      t = BxBlockAddress::Address.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should has_one shared_address " do
      t = BxBlockAddress::Address.reflect_on_association(:shared_address)
      expect(t.macro).to eq(:has_one)
    end 
    
    it{ should accept_nested_attributes_for :shared_address }

    context "validations test" do
      it "ensure presence of some attributes" do
        email_address = BxBlockAddress::Address.create()
        expect(email_address.errors.messages[:email_address]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        phone_number = BxBlockAddress::Address.create()
        expect(phone_number.errors.messages[:phone_number]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        full_name = BxBlockAddress::Address.create()
        expect(full_name.errors.messages[:full_name]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        pincode = BxBlockAddress::Address.create()
        expect(pincode.errors.messages[:pincode]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        city = BxBlockAddress::Address.create()
        expect(city.errors.messages[:city]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        address = BxBlockAddress::Address.create()
        expect(address.errors.messages[:address]).to eq(["can't be blank"])
      end
      it "ensure presence of some attributes" do
        state = BxBlockAddress::Address.create()
        expect(state.errors.messages[:state]).to eq(["can't be blank"])
      end
    end
  end
end

