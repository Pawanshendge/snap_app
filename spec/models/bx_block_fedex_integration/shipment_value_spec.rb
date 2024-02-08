require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::ShipmentValue, type: :model do
  context "association test" do
  	it "should belongs_to shipment " do
  		t = BxBlockFedexIntegration::ShipmentValue.reflect_on_association(:shipment)
  		expect(t.macro).to eq(:belongs_to)
  	end    
  end
end
