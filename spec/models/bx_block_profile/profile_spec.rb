require 'rails_helper'

RSpec.describe BxBlockProfile::Profile, type: :model do
  context "association test" do
    it "should has_one_attached photo " do
      t = BxBlockProfile::Profile.reflect_on_attachment(:photo)
      expect(t.macro).to eq(:has_one_attached)
    end    
    it "should belongs_to account " do
      t = BxBlockProfile::Profile.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end   
    it "should has_one current_status " do
      t = BxBlockProfile::Profile.reflect_on_association(:current_status)
      expect(t.macro).to eq(:has_one)
    end    
    it "should has_one publication_patent " do
      t = BxBlockProfile::Profile.reflect_on_association(:publication_patent)
      expect(t.macro).to eq(:has_one)
    end    
    it "should has_many awards " do
      t = BxBlockProfile::Profile.reflect_on_association(:awards)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many hobbies " do
      t = BxBlockProfile::Profile.reflect_on_association(:hobbies)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many courses " do
      t = BxBlockProfile::Profile.reflect_on_association(:courses)
      expect(t.macro).to eq(:has_many)
    end   
    it "should has_many test_score_and_courses " do
      t = BxBlockProfile::Profile.reflect_on_association(:test_score_and_courses)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many career_experiences " do
      t = BxBlockProfile::Profile.reflect_on_association(:career_experiences)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_one video " do
      t = BxBlockProfile::Profile.reflect_on_association(:video)
      expect(t.macro).to eq(:has_one)
    end    
    it "should has_many educational_qualifications " do
      t = BxBlockProfile::Profile.reflect_on_association(:educational_qualifications)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many projects " do
      t = BxBlockProfile::Profile.reflect_on_association(:projects)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many languages " do
      t = BxBlockProfile::Profile.reflect_on_association(:languages)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many contacts " do
      t = BxBlockProfile::Profile.reflect_on_association(:contacts)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many jobs " do
      t = BxBlockProfile::Profile.reflect_on_association(:jobs)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many applied_jobs " do
      t = BxBlockProfile::Profile.reflect_on_association(:applied_jobs)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many follows " do
      t = BxBlockProfile::Profile.reflect_on_association(:follows)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many interview_schedules " do
      t = BxBlockProfile::Profile.reflect_on_association(:interview_schedules)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_and_belongs_to_many company_pages " do
      t = BxBlockProfile::Profile.reflect_on_association(:company_pages)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end    
    it { should validate_presence_of(:profile_role) }
    it{ should accept_nested_attributes_for :current_status }         
    it{ should accept_nested_attributes_for :publication_patent }         
    it{ should accept_nested_attributes_for :awards }         
    it{ should accept_nested_attributes_for :hobbies }         
    it{ should accept_nested_attributes_for :courses }         
    it{ should accept_nested_attributes_for :test_score_and_courses }         
    it{ should accept_nested_attributes_for :career_experiences }         
    it{ should accept_nested_attributes_for :educational_qualifications }         
    it{ should accept_nested_attributes_for :projects }         
  end
end