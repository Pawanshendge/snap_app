require 'rails_helper'

RSpec.describe BxBlockCategories::SubCategory, type: :model do
  context "association test" do
  	it "should has_and_belongs_to_many categories " do
  		t = BxBlockCategories::SubCategory.reflect_on_association(:categories)
  		expect(t.macro).to eq(:has_and_belongs_to_many)
  	end	  
    it "should belongs_to parent " do
      t = BxBlockCategories::SubCategory.reflect_on_association(:parent)
      expect(t.macro).to eq(:belongs_to)
    end  
    it "should has_many sub_categories " do
      t = BxBlockCategories::SubCategory.reflect_on_association(:sub_categories)
      expect(t.macro).to eq(:has_many)
    end  
    it "should has_many user_sub_categories " do
      t = BxBlockCategories::SubCategory.reflect_on_association(:user_sub_categories)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many account " do
      t = BxBlockCategories::SubCategory.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end  
    it "ensure presence of some attributes" do
      sub_category = BxBlockCategories::SubCategory.create()
      expect(sub_category.errors.messages[:name]).to eq(["can't be blank"])
    end  
    it "ensure presence of some attributes" do
      sub_category = BxBlockCategories::SubCategory.create()
      expect(sub_category.errors.messages[:base]).to eq(["Please select categories or a parent."])
    end                
  end
end
