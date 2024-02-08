require 'rails_helper'

RSpec.describe BxBlockPaymentAdmin::PaymentAdmin, type: :model do
  context "association test" do
    it "should belongs_to current_user " do
      t = BxBlockPaymentAdmin::PaymentAdmin.reflect_on_association(:current_user)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to account " do
      t = BxBlockPaymentAdmin::PaymentAdmin.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end