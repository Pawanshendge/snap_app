require 'rails_helper'

RSpec.describe BxBlockBook::DeliveryCharge, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      delivery_charges = BxBlockBook::DeliveryCharge.create()
      expect(delivery_charges.errors.messages[:charge]).to eq(["can't be blank"])
    end
    describe 'ensure uniqueness of some attributes' do
      it { should validate_uniqueness_of(:charge) }
    end
  end
end