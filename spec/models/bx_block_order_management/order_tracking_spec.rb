require 'rails_helper'

RSpec.describe BxBlockOrderManagement::OrderTracking, type: :model do
  context "association test" do
    it "should belongs_to parent " do
      t = BxBlockOrderManagement::OrderTracking.reflect_on_association(:parent)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to tracking " do
      t = BxBlockOrderManagement::OrderTracking.reflect_on_association(:tracking)
      expect(t.macro).to eq(:belongs_to)
    end
  end 
end