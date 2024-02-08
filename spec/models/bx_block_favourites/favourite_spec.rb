require 'rails_helper'

RSpec.describe BxBlockFavourites::Favourite, type: :model do
  context "association test" do
  	it "should belongs_to favouriteable " do
  		t = BxBlockFavourites::Favourite.reflect_on_association(:favouriteable)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
