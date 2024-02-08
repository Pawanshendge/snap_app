require 'rails_helper'

RSpec.describe BxBlockProfile::CurrentStatus, type: :model do
  context "association test" do
    it "should belongs_to profile " do
      t = BxBlockProfile::CurrentStatus.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end    
    it "should has_many current_status_industrys " do
      t = BxBlockProfile::CurrentStatus.reflect_on_association(:current_status_industrys)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many current_status_employment_types " do
      t = BxBlockProfile::CurrentStatus.reflect_on_association(:current_status_employment_types)
      expect(t.macro).to eq(:has_many)
    end    
    it "should has_many current_annual_salary_current_status " do
      t = BxBlockProfile::CurrentStatus.reflect_on_association(:current_annual_salary_current_status)
      expect(t.macro).to eq(:has_many)
    end  
  end 
end 