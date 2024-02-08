require 'rails_helper'

RSpec.describe AccountBlock::BlackListUser, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = AccountBlock::BlackListUser.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
