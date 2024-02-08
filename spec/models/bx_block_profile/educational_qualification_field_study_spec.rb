require 'rails_helper'

RSpec.describe BxBlockProfile::EducationalQualificationFieldStudy, type: :model do
  context "association test" do
    it "should belongs_to field_study " do
      t = BxBlockProfile::EducationalQualificationFieldStudy.reflect_on_association(:field_study)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to educational_qualification " do
      t = BxBlockProfile::EducationalQualificationFieldStudy.reflect_on_association(:educational_qualification)
      expect(t.macro).to eq(:belongs_to)
    end  
  end 
end 