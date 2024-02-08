# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: "BxBlockComments::Comment" do
    comment { "Test Comment" }
    account
    commentable { nil }
  end
end
