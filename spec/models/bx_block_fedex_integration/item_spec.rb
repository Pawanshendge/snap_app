require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::Item, type: :model do
  context "association test" do
  	it "should belongs_to shipment " do
  		t = BxBlockFedexIntegration::Item.reflect_on_association(:shipment)
  		expect(t.macro).to eq(:belongs_to)
  	end    
    it "should has_one dimension " do
      t = BxBlockFedexIntegration::Item.reflect_on_association(:dimension)
      expect(t.macro).to eq(:has_one)
    end	
    it { is_expected.to callback(:set_ref_id).after(:initialize) }
    it{ should accept_nested_attributes_for :dimension }    
  end
end
