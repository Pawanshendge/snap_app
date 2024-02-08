require 'rails_helper'

RSpec.describe BxBlockCouponCg::CouponCode, type: :model do
  context "validations test" do
    describe 'ensure validate of some attributes' do
      it { should validate_length_of(:title) }
      it { should validate_length_of(:description) }
      it { should validate_length_of(:code) }  
    end
  end
end