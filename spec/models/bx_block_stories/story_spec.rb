require 'rails_helper'

RSpec.describe BxBlockStories::Story, type: :model do
  context "association test" do
    it "should has_one_attached story_file " do
      t = BxBlockStories::Story.reflect_on_attachment(:story_file)
      expect(t.macro).to eq(:has_one_attached)
    end 
    it { should validate_presence_of(:valid_till) }    
    it { should validate_length_of(:title) }
  end
end