FactoryBot.define do
  factory :subscription, class: "BxBlockCustomUserSubs::Subscription" do
    name {"demo"}
    details {"khanhbeib"}
    active {}
    book_original_price {}
    no_of_books {}
    gift_included {}
    valid_up_to {"01/10/2023"}
    total_amount {}
    subscription_package_amount {}
  end
end