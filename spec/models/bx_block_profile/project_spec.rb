require 'rails_helper'

RSpec.describe BxBlockProfile::Project, type: :model do
  context "association test" do
    it "should belongs_to profile " do
      t = BxBlockProfile::Project.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end    
    it "should has_many associated_projects " do
      t = BxBlockProfile::Project.reflect_on_association(:associated_projects)
      expect(t.macro).to eq(:has_many)
    end
  end
end