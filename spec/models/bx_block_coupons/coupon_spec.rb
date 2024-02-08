require 'rails_helper'

RSpec.describe BxBlockCoupons::Coupon, type: :model do
  context "association test" do
    it "should has_many coupon_services " do
      t = BxBlockCoupons::Coupon.reflect_on_association(:coupon_services)
      expect(t.macro).to eq(:has_many)
    end       
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:discount) }
      it { should validate_presence_of(:coupon_type) } 
      it { should validate_presence_of(:min_order) }
      it { should validate_presence_of(:status) } 
      it { should validate_presence_of(:max_discount) }
    end
    it{ should accept_nested_attributes_for :coupon_services }    
  end
end