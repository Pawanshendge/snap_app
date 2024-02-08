require 'rails_helper'

RSpec.describe BxBlockOrderManagement::OrderItem, type: :model do
  context "association test" do
    it "should belongs_to catalogue_variant " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:catalogue_variant)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to catalogue " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:catalogue)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to order " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end      
    it "should belongs_to order_status " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:order_status)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_many order_trackings " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:order_trackings)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many trackings " do
      t = BxBlockOrderManagement::OrderItem.reflect_on_association(:trackings)
      expect(t.macro).to eq(:has_many)
    end 
    it { is_expected.to callback(:set_item_status).before(:save) }   
    it { is_expected.to callback(:update_product_stock).after(:save) }   
  end
end