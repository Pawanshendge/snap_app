require 'rails_helper'

RSpec.describe BxBlockProfile::CurrentAnnualSalary, type: :model do
  context "association test" do
    it "should has_many current_annual_salary_current_status " do
      t = BxBlockProfile::CurrentAnnualSalary.reflect_on_association(:current_annual_salary_current_status)
      expect(t.macro).to eq(:has_many)
    end 
  end
end