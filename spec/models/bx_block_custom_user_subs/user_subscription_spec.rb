require 'rails_helper'

RSpec.describe BxBlockCustomUserSubs::UserSubscription, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockCustomUserSubs::UserSubscription.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end    
    it "should belongs_to subscription " do
      t = BxBlockCustomUserSubs::UserSubscription.reflect_on_association(:subscription)
      expect(t.macro).to eq(:belongs_to)
    end	
  end
end
