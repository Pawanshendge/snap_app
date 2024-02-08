require 'rails_helper'

RSpec.describe BxBlockCoupons::ComboOffer, type: :model do
  context "association test" do
    it "should has_and_belongs_to_many sub_categories " do
      t = BxBlockCoupons::ComboOffer.reflect_on_association(:sub_categories)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end     
    it "should has_one_attached logo " do
      t = BxBlockCoupons::ComboOffer.reflect_on_attachment(:logo)
      expect(t.macro).to eq(:has_one_attached)
    end     
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:discount_percentage) }
      it { should validate_presence_of(:offer_start_date) } 
      it { should validate_presence_of(:offer_end_date) }
    end
    it { is_expected.to callback(:calc_final_price).before(:save) }
    
  end
end