require 'rails_helper'

RSpec.describe BxBlockLocation::VanMember, type: :model do
  context "association test" do
    it "should belongs_to van " do
      t = BxBlockLocation::VanMember.reflect_on_association(:van)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockLocation::VanMember.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end     
  end
end