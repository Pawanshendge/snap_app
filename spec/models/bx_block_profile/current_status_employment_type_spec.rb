require 'rails_helper'

RSpec.describe BxBlockProfile::CurrentStatusEmploymentType, type: :model do
  context "association test" do
    it "should belongs_to current_status " do
      t = BxBlockProfile::CurrentStatusEmploymentType.reflect_on_association(:current_status)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to employment_type " do
      t = BxBlockProfile::CurrentStatusEmploymentType.reflect_on_association(:employment_type)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end