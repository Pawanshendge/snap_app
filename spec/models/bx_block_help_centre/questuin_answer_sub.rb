require 'rails_helper'

RSpec.describe BxBlockHelpCentre::QuestionAnswer, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      question = BxBlockHelpCentre::QuestionAnswer.create()
      expect(question.errors.messages[:question]).to eq(["Question required."])
    end
  end
end