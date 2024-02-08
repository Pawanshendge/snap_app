require 'rails_helper'

RSpec.describe BxBlockCoupons::CouponService, type: :model do
  context "association test" do
  	it "should belongs_to coupon " do
  		t = BxBlockCoupons::CouponService.reflect_on_association(:coupon)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
    it "should belongs_to sub_categories " do
      t = BxBlockCoupons::CouponService.reflect_on_association(:sub_categories)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end
