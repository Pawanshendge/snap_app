require 'rails_helper'

RSpec.describe BxBlockProfile::FieldStudy, type: :model do
  context "association test" do
    it "should has_many educational_qualification_field_studys " do
      t = BxBlockProfile::FieldStudy.reflect_on_association(:educational_qualification_field_studys)
      expect(t.macro).to eq(:has_many)
    end      
  end 
end 