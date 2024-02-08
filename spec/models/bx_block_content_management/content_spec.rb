require 'rails_helper'

RSpec.describe BxBlockContentManagement::Content, type: :model do
  context "association test" do
  	it "should belongs_to category " do
  		t = BxBlockContentManagement::Content.reflect_on_association(:category)
  		expect(t.macro).to eq(:belongs_to)
  	end	  
    it "should belongs_to sub_category " do
      t = BxBlockContentManagement::Content.reflect_on_association(:sub_category)
      expect(t.macro).to eq(:belongs_to)
    end  
    it "should belongs_to content_type " do
      t = BxBlockContentManagement::Content.reflect_on_association(:content_type)
      expect(t.macro).to eq(:belongs_to)
    end  
    it "should belongs_to language " do
      t = BxBlockContentManagement::Content.reflect_on_association(:language)
      expect(t.macro).to eq(:belongs_to)
    end  
    it "should belongs_to contentable " do
      t = BxBlockContentManagement::Content.reflect_on_association(:contentable)
      expect(t.macro).to eq(:belongs_to)
    end 
    it "should belongs_to author " do
      t = BxBlockContentManagement::Content.reflect_on_association(:author)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_many bookmarks " do
      t = BxBlockContentManagement::Content.reflect_on_association(:bookmarks)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many account_bookmarks " do
      t = BxBlockContentManagement::Content.reflect_on_association(:account_bookmarks)
      expect(t.macro).to eq(:has_many)
    end
    it{ should accept_nested_attributes_for :contentable }   
    it { is_expected.to callback(:set_defaults).after(:initialize) } 
  end
end

