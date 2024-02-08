require 'rails_helper'

RSpec.describe BxBlockReviews::Review, type: :model do
  context "association test" do
    it "should belongs_to reviewer " do
      t = BxBlockReviews::Review.reflect_on_association(:reviewer)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockReviews::Review.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end  
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end 
end 