require 'rails_helper'

RSpec.describe BxBlockCatalogue::Review, type: :model do
  context "association test" do
  	it "should belongs_to catalogue " do
  		t = BxBlockCatalogue::Review.reflect_on_association(:catalogue)
  		expect(t.macro).to eq(:belongs_to)
  	end	   
  end
end
