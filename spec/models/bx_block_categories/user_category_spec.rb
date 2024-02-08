require 'rails_helper'

RSpec.describe BxBlockCategories::UserCategory, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockCategories::UserCategory.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to category " do
      t = BxBlockCategories::UserCategory.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end     
  end
end
