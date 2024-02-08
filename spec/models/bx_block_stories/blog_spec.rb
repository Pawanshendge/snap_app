require 'rails_helper'

RSpec.describe BxBlockStories::Blog, type: :model do
  context "association test" do
    it "should has_one_attached blog_file " do
      t = BxBlockStories::Blog.reflect_on_attachment(:blog_file)
      expect(t.macro).to eq(:has_one_attached)
    end 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }    
    it { should validate_presence_of(:status) }
    it { should validate_length_of(:title) }
    it { is_expected.to callback(:save_blog_url).after(:save) }
  end
end
