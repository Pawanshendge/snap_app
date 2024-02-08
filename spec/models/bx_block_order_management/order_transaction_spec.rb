require 'rails_helper'

RSpec.describe BxBlockOrderManagement::OrderTransaction, type: :model do
  context "association test" do
    it "should belongs_to account " do
      t = BxBlockOrderManagement::OrderTransaction.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to order " do
      t = BxBlockOrderManagement::OrderTransaction.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end
  end 
end