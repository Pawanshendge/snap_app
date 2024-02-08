require 'rails_helper'

RSpec.describe BxBlockCustomForm::SellerAccount, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockCustomForm::SellerAccount.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
