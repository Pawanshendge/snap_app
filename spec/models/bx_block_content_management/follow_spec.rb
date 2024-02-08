require 'rails_helper'

RSpec.describe BxBlockContentManagement::Follow, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockContentManagement::Follow.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
