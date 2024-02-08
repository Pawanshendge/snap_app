require 'rails_helper'

RSpec.describe BxBlockCatalogue::Catalogue, type: :model do
  context "association test" do
  	it "should belongs_to category " do
  		t = BxBlockCatalogue::Catalogue.reflect_on_association(:category)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to sub_category " do
      t = BxBlockCatalogue::Catalogue.reflect_on_association(:sub_category)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should belongs_to brand " do
      t = BxBlockCatalogue::Catalogue.reflect_on_association(:brand)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should has_many reviews " do
      t = BxBlockCatalogue::Catalogue.reflect_on_association(:reviews)
      expect(t.macro).to eq(:has_many)
    end  
    it "should has_many catalogue_variants " do
      t = BxBlockCatalogue::Catalogue.reflect_on_association(:catalogue_variants)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_and_belongs_to_many tags " do
      t = BxBlockCatalogue::Catalogue.reflect_on_association(:tags)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end 
    it "should has_many_attached images " do
      t = BxBlockCatalogue::Catalogue.reflect_on_attachment(:images)
      expect(t.macro).to eq(:has_many_attached)
    end   
    it{ should accept_nested_attributes_for :catalogue_variants }                     
  end
end
