require 'rails_helper'

RSpec.describe BxBlockProfile::EducationalQualification, type: :model do
  context "association test" do
    it "should belongs_to profile " do
      t = BxBlockProfile::EducationalQualification.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should has_many degree_educational_qualifications " do
      t = BxBlockProfile::EducationalQualification.reflect_on_association(:degree_educational_qualifications)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many educational_qualification_field_studys " do
      t = BxBlockProfile::EducationalQualification.reflect_on_association(:educational_qualification_field_studys)
      expect(t.macro).to eq(:has_many)
    end 
  end
end