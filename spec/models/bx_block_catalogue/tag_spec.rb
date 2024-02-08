require 'rails_helper'

RSpec.describe BxBlockCatalogue::Tag, type: :model do
  context "association test" do
  	it "should has_and_belongs_to_many catalogue " do
  		t = BxBlockCatalogue::Tag.reflect_on_association(:catalogue)
  		expect(t.macro).to eq(:has_and_belongs_to_many)
  	end	   
  end
end
