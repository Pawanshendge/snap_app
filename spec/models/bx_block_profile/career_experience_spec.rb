require 'rails_helper'

RSpec.describe BxBlockProfile::CareerExperience, type: :model do
  context "association test" do       
    it "should belongs_to profile " do
      t = BxBlockProfile::CareerExperience.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_many career_experience_industrys " do
      t = BxBlockProfile::CareerExperience.reflect_on_association(:career_experience_industrys)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many career_experience_employment_types " do
      t = BxBlockProfile::CareerExperience.reflect_on_association(:career_experience_employment_types)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many career_experience_system_experiences " do
      t = BxBlockProfile::CareerExperience.reflect_on_association(:career_experience_system_experiences)
      expect(t.macro).to eq(:has_many)
    end   
  end
end