require 'rails_helper'

RSpec.describe BxBlockProfile::EmploymentType, type: :model do
  context "association test" do
    it "should has_many current_status_employment_types " do
      t = BxBlockProfile::EmploymentType.reflect_on_association(:current_status_employment_types)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many career_experience_employment_types " do
      t = BxBlockProfile::EmploymentType.reflect_on_association(:career_experience_employment_types)
      expect(t.macro).to eq(:has_many)
    end  
  end 
end 