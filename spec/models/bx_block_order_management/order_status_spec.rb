require 'rails_helper'

RSpec.describe BxBlockOrderManagement::OrderStatus, type: :model do
  context "association test" do
    it "should has_many orders " do
      t = BxBlockOrderManagement::OrderStatus.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end       
    it "should has_many order_items " do
      t = BxBlockOrderManagement::OrderStatus.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end        
    it { should validate_uniqueness_of(:status) }  
    it { is_expected.to callback(:add_status).before(:save) }  
  end
end