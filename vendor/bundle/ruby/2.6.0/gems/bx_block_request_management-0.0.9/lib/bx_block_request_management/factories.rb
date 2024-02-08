FactoryBot.define do
  factory :request, class: "BxBlockRequestManagement::Request" do
    sender { create(:account) }
    request_text { "Request text" }
    status { nil }
  end
end
