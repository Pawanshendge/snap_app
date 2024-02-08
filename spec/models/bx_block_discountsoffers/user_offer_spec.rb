require 'rails_helper'

RSpec.describe BxBlockDiscountsoffers::UserOffer, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockDiscountsoffers::UserOffer.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
    it "should belongs_to offer " do
      t = BxBlockDiscountsoffers::UserOffer.reflect_on_association(:offer)
      expect(t.macro).to eq(:belongs_to)
    end 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:code) }
    end
  end
end
