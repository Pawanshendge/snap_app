require 'rails_helper'

RSpec.describe BxBlockHelpCentre::QuestionSubType, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      sub_type = BxBlockHelpCentre::QuestionSubType.create()
      expect(sub_type.errors.messages[:sub_type]).to eq(["Question sub type required."])
    end
    it "should belongs_to question_type " do
      t = BxBlockHelpCentre::QuestionSubType.reflect_on_association(:question_type)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end