require 'rails_helper'

RSpec.describe BxBlockProfile::CurrentAnnualSalaryCurrentStatus, type: :model do
  context "association test" do
    it "should belongs_to current_status " do
      t = BxBlockProfile::CurrentAnnualSalaryCurrentStatus.reflect_on_association(:current_status)
      expect(t.macro).to eq(:belongs_to)
    end
    it "should belongs_to current_annual_salary " do
      t = BxBlockProfile::CurrentAnnualSalaryCurrentStatus.reflect_on_association(:current_annual_salary)
      expect(t.macro).to eq(:belongs_to)
    end  
  end 
end 