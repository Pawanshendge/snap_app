ActiveAdmin.register BxBlockHelpCentre::QuestionAnswer, as: "Question Answers" do
  permit_params :question, :answer
end
