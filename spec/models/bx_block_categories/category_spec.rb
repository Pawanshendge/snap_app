require 'rails_helper'

RSpec.describe BxBlockCategories::Category, type: :model do
  context "association test" do
  	it "should has_and_belongs_to_many sub_categories " do
  		t = BxBlockCategories::Category.reflect_on_association(:sub_categories)
  		expect(t.macro).to eq(:has_and_belongs_to_many)
  	end	  
    it "should has_many contents " do
      t = BxBlockCategories::Category.reflect_on_association(:contents)
      expect(t.macro).to eq(:has_many)
    end  
    it "should has_many ctas " do
      t = BxBlockCategories::Category.reflect_on_association(:ctas)
      expect(t.macro).to eq(:has_many)
    end  
    it "should has_many user_categories " do
      t = BxBlockCategories::Category.reflect_on_association(:user_categories)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many account " do
      t = BxBlockCategories::Category.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end  
    it "ensure presence of some attributes" do
      category = BxBlockCategories::Category.create()
      expect(category.errors.messages[:name]).to eq(["can't be blank"])
    end  
  end
end