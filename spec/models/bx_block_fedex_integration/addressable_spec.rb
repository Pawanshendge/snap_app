require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::Addressable, type: :model do
  context "association test" do
  	it "should belongs_to shipment " do
  		t = BxBlockFedexIntegration::Addressable.reflect_on_association(:shipment)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
    it "should has_one arrival_window " do
      t = BxBlockFedexIntegration::Addressable.reflect_on_association(:arrival_window)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_one coordinate " do
      t = BxBlockFedexIntegration::Addressable.reflect_on_association(:coordinate)
      expect(t.macro).to eq(:has_one)
    end
    it{ should accept_nested_attributes_for :arrival_window }     
    it{ should accept_nested_attributes_for :coordinate }     
  end
end
