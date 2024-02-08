FactoryBot.define do
  factory :question_type, :class => 'BxBlockHelpCentre::QuestionType' do
    que_type { "Fan Questions" }
    description { "Learn how to be a true fan" }
  end

  factory :question_sub_type, :class => 'BxBlockHelpCentre::QuestionSubType' do
    sub_type { "Question Sub Type" }
    description { "Question Sub Type Description" }
    question_type
  end

  factory :question_answer, :class => 'BxBlockHelpCentre::QuestionAnswer' do
    question { "Test Question" }
    answer { "Test Answer" }
    question_sub_type
  end
end
