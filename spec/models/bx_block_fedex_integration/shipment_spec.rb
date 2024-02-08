require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::Shipment, type: :model do
  context "association test" do
  	it "should belongs_to create_shipment " do
  		t = BxBlockFedexIntegration::Shipment.reflect_on_association(:create_shipment)
  		expect(t.macro).to eq(:belongs_to)
  	end    
    it "should has_one cod_value " do
      t = BxBlockFedexIntegration::Shipment.reflect_on_association(:cod_value)
      expect(t.macro).to eq(:has_one)
    end	    
    it "should has_one shipment_value " do
      t = BxBlockFedexIntegration::Shipment.reflect_on_association(:shipment_value)
      expect(t.macro).to eq(:has_one)
    end      
    it "should has_one delivery " do
      t = BxBlockFedexIntegration::Shipment.reflect_on_association(:delivery)
      expect(t.macro).to eq(:has_one)
    end      
    it "should has_one pickup " do
      t = BxBlockFedexIntegration::Shipment.reflect_on_association(:pickup)
      expect(t.macro).to eq(:has_one)
    end      
    it "should has_many items " do
      t = BxBlockFedexIntegration::Shipment.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end
    it { is_expected.to callback(:set_ref_id).after(:initialize) }
    it{ should accept_nested_attributes_for :cod_value } 
    it{ should accept_nested_attributes_for :shipment_value } 
    it{ should accept_nested_attributes_for :delivery } 
    it{ should accept_nested_attributes_for :pickup } 
    it{ should accept_nested_attributes_for :items } 
  end
end
