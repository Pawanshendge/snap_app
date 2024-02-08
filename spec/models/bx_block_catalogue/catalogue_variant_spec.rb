require 'rails_helper'

RSpec.describe BxBlockCatalogue::CatalogueVariant, type: :model do
  context "association test" do
  	it "should belongs_to catalogue " do
  		t = BxBlockCatalogue::CatalogueVariant.reflect_on_association(:catalogue)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to catalogue_variant_color " do
      t = BxBlockCatalogue::CatalogueVariant.reflect_on_association(:catalogue_variant_color)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should belongs_to catalogue_variant_size " do
      t = BxBlockCatalogue::CatalogueVariant.reflect_on_association(:catalogue_variant_size)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should has_one_attached images " do
      t = BxBlockCatalogue::CatalogueVariant.reflect_on_attachment(:images)
      expect(t.macro).to eq(:has_many_attached)
    end                        
  end
end
