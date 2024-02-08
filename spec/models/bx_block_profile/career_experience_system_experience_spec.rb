require 'rails_helper'

RSpec.describe BxBlockProfile::CareerExperienceIndustry, type: :model do
  context "association test" do
    it "should belongs_to career_experience " do
      t = BxBlockProfile::CareerExperienceIndustry.reflect_on_association(:career_experience)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to industry " do
      t = BxBlockProfile::CareerExperienceIndustry.reflect_on_association(:industry)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end