require 'rails_helper'

RSpec.describe BxBlockProfile::CurrentStatusIndustry, type: :model do
  context "association test" do
    it "should belongs_to current_status " do
      t = BxBlockProfile::CurrentStatusIndustry.reflect_on_association(:current_status)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to industry " do
      t = BxBlockProfile::CurrentStatusIndustry.reflect_on_association(:industry)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end