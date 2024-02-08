require 'rails_helper'

RSpec.describe BxBlockProfile::AssociatedProject, type: :model do
  context "association test" do
    it "should belongs_to project " do
      t = BxBlockProfile::AssociatedProject.reflect_on_association(:project)
      expect(t.macro).to eq(:belongs_to)
    end    
    it "should belongs_to associated " do
      t = BxBlockProfile::AssociatedProject.reflect_on_association(:associated)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end 