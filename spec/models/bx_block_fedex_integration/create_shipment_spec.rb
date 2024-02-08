require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::CreateShipment, type: :model do
  context "association test" do
  	it "should has_many shipments " do
  		t = BxBlockFedexIntegration::CreateShipment.reflect_on_association(:shipments)
  		expect(t.macro).to eq(:has_many)
  	end
    it { is_expected.to callback(:set_default_values).after(:initialize) }
    it{ should accept_nested_attributes_for :shipments }    	   
  end
end
