require 'rails_helper'

RSpec.describe BxBlockCatalogue::CataloguesTag, type: :model do
  context "association test" do
  	it "should belongs_to catalogue " do
  		t = BxBlockCatalogue::CataloguesTag.reflect_on_association(:catalogue)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to tag " do
      t = BxBlockCatalogue::CataloguesTag.reflect_on_association(:tag)
      expect(t.macro).to eq(:belongs_to)
    end     
  end
end
