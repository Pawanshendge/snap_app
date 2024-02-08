require 'rails_helper'

RSpec.describe BxBlockOrdersummary::OrderSummary, type: :model do
  context "association test" do
    it "should belongs_to orders " do
      t = BxBlockOrdersummary::OrderSummary.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end