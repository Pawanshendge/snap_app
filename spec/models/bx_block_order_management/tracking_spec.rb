require 'rails_helper'

RSpec.describe BxBlockOrderManagement::Tracking, type: :model do
  context "association test" do
    it "should has_many order_trackings " do
      t = BxBlockOrderManagement::Tracking.reflect_on_association(:order_trackings)
      expect(t.macro).to eq(:has_many)
    end       
    it "should has_many orders " do
      t = BxBlockOrderManagement::Tracking.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many order_items " do
      t = BxBlockOrderManagement::Tracking.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end 
    it { is_expected.to callback(:add_tracking_number).before(:create) }
  end
end