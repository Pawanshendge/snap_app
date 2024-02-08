require 'rails_helper'

RSpec.describe BxBlockPosts::Post, type: :model do
  context "association test" do
    it "should has_many_attached images " do
      t = BxBlockPosts::Post.reflect_on_attachment(:images)
      expect(t.macro).to eq(:has_many_attached)
    end       
    it "should belongs_to category " do
      t = BxBlockPosts::Post.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to sub_category " do
      t = BxBlockPosts::Post.reflect_on_association(:sub_category)
      expect(t.macro).to eq(:belongs_to)
    end    
    it "should belongs_to account " do
      t = BxBlockPosts::Post.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end    
    it "should has_many_attached media " do
      t = BxBlockPosts::Post.reflect_on_attachment(:media)
      expect(t.macro).to eq(:has_many_attached)
    end   
    it { should validate_presence_of(:body) }   
  end
end