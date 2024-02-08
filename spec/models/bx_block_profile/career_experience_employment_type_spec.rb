require 'rails_helper'

RSpec.describe BxBlockProfile::CareerExperienceEmploymentType, type: :model do
  context "association test" do
    it "should belongs_to career_experience " do
      t = BxBlockProfile::CareerExperienceEmploymentType.reflect_on_association(:career_experience)
      expect(t.macro).to eq(:belongs_to)
    end       
    it "should belongs_to employment_type " do
      t = BxBlockProfile::CareerExperienceEmploymentType.reflect_on_association(:employment_type)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end