require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::Coordinate, type: :model do
  context "association test" do
  	it "should belongs_to addressable " do
  		t = BxBlockFedexIntegration::Coordinate.reflect_on_association(:addressable)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
  end
end
