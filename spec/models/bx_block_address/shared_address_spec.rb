require 'rails_helper'

RSpec.describe BxBlockAddress::SharedAddress, type: :model do
  context "association test" do
  	it "should belongs_to address " do
  		t = BxBlockAddress::SharedAddress.reflect_on_association(:address)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end