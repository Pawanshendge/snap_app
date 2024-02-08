require 'rails_helper'

RSpec.describe BxBlockProfile::Industry, type: :model do
  context "association test" do
    it "should has_many current_status_industrys " do
      t = BxBlockProfile::Industry.reflect_on_association(:current_status_industrys)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many career_experience_industrys " do
      t = BxBlockProfile::Industry.reflect_on_association(:career_experience_industrys)
      expect(t.macro).to eq(:has_many)
    end  
  end
end