require 'rails_helper'

RSpec.describe BxBlockDiscountsoffers::Offer, type: :model do
  context "validations test" do
    describe 'ensure validate of some attributes' do
      it { should validate_uniqueness_of(:code) }
      it { should validate_presence_of(:discount_type) }
      it { should validate_presence_of(:min_cart_value) }
      it { should validate_presence_of(:discount) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:valid_from) }
      it { should validate_presence_of(:valid_to) }
    end
  end
    describe "#Enum" do
      it { should define_enum_for(:combine_with_other_offer).with_values([:inactive, :active]) }
      it { should define_enum_for(:coupon_type).with_values([:normal, :referral, :share_order_code, :specfic_user]) }
      it { should define_enum_for(:valid_for).with_values([:new_users, :old_users, :all_users]) }
    end
end
