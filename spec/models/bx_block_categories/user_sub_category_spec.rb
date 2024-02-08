require 'rails_helper'

RSpec.describe BxBlockCategories::UserSubCategory, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockCategories::UserSubCategory.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to sub_category " do
      t = BxBlockCategories::UserSubCategory.reflect_on_association(:sub_category)
      expect(t.macro).to eq(:belongs_to)
    end     
  end
end
