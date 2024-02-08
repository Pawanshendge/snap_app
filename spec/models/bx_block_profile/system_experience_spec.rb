require 'rails_helper'

RSpec.describe BxBlockProfile::SystemExperience, type: :model do
  context "association test" do
    it "should has_many career_experience_system_experiences " do
      t = BxBlockProfile::SystemExperience.reflect_on_association(:career_experience_system_experiences)
      expect(t.macro).to eq(:has_many)
    end
  end
end