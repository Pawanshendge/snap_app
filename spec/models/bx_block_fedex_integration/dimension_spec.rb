require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::Dimension, type: :model do
  context "association test" do
  	it "should belongs_to item " do
  		t = BxBlockFedexIntegration::Dimension.reflect_on_association(:item)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
  end
end
