require 'rails_helper'

RSpec.describe BxBlockHelpCentre::QuestionType, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      que_type = BxBlockHelpCentre::QuestionType.create()
      expect(que_type.errors.messages[:que_type]).to eq(["Question type required."])
    end
    it "should has_many question_sub_types " do
      t = BxBlockHelpCentre::QuestionType.reflect_on_association(:question_sub_types)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many question_answers " do
      t = BxBlockHelpCentre::QuestionType.reflect_on_association(:question_answers)
      expect(t.macro).to eq(:has_many)
    end 
    it{ should accept_nested_attributes_for :question_sub_types }             
  end
end