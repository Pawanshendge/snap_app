require 'rails_helper'

RSpec.describe BxBlockLocation::Van, type: :model do
  context "association test" do
    it "should has_one location " do
      t = BxBlockLocation::Van.reflect_on_association(:location)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_one service_provider " do
      t = BxBlockLocation::Van.reflect_on_association(:service_provider)
      expect(t.macro).to eq(:has_one)
    end     
    it "should has_many assistants " do
      t = BxBlockLocation::Van.reflect_on_association(:assistants)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many van_members " do
      t = BxBlockLocation::Van.reflect_on_association(:van_members)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many reviews " do
      t = BxBlockLocation::Van.reflect_on_association(:reviews)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_one_attached main_photo " do
      t = BxBlockLocation::Van.reflect_on_attachment(:main_photo)
      expect(t.macro).to eq(:has_one_attached)
    end     
    it "should has_many_attached galleries " do
      t = BxBlockLocation::Van.reflect_on_attachment(:galleries)
      expect(t.macro).to eq(:has_many_attached)
    end 
    it { should validate_presence_of(:name) }  
    it{ should accept_nested_attributes_for :van_members }         
    it{ should accept_nested_attributes_for :service_provider }         
    it{ should accept_nested_attributes_for :assistants }  
    it { is_expected.to callback(:offline_van).before(:create) }
    it { is_expected.to callback(:assign_location).after(:create) }
  end
end