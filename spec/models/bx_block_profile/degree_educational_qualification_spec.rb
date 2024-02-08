require 'rails_helper'

RSpec.describe BxBlockProfile::DegreeEducationalQualification, type: :model do
  context "association test" do
    it "should belongs_to degree " do
      t = BxBlockProfile::DegreeEducationalQualification.reflect_on_association(:degree)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to educational_qualification " do
      t = BxBlockProfile::DegreeEducationalQualification.reflect_on_association(:educational_qualification)
      expect(t.macro).to eq(:belongs_to)
    end     
  end
end