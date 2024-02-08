require 'rails_helper'

RSpec.describe BxBlockCategories::Cta, type: :model do
  context "association test" do
  	it "should belongs_to category " do
  		t = BxBlockCategories::Cta.reflect_on_association(:category)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
