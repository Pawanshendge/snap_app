require 'rails_helper'

RSpec.describe BxBlockCoupons::OrderComboOffer, type: :model do
  context "association test" do
  	it "should belongs_to order " do
  		t = BxBlockCoupons::OrderComboOffer.reflect_on_association(:order)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
    it "should belongs_to combo_offer " do
      t = BxBlockCoupons::OrderComboOffer.reflect_on_association(:combo_offer)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end
