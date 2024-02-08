require 'rails_helper'

RSpec.describe BxBlockLocation::Location, type: :model do
  context "association test" do
    it "should belongs_to van " do
      t = BxBlockLocation::Location.reflect_on_association(:van)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end