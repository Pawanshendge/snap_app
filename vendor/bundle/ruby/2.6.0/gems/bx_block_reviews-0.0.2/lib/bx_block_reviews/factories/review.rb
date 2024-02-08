FactoryBot.define do
  factory :review, class: 'BxBlockReviews::Review' do
    title { 'Test' }
    description { 'Test' }
    anonymous { true }
    association :account, factory: :account
    association :reviewer, factory: :account
  end
end
