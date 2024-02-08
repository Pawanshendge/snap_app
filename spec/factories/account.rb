# FactoryBot.define do
#   factory :account, :class => 'AccountBlock::Account' do
#     activated { true }

#     factory :email_account, :class => 'AccountBlock::EmailAccount' do
#       email { generate :account_email }
#     end

#     factory :sms_account, :class => 'AccountBlock::SmsAccount' do
#       full_phone_number { generate :phone_number }
#     end
#   end
# end

FactoryBot.define do
  factory :account, :class => AccountBlock::Account do
    email  { Faker::Internet.free_email}
    full_phone_number { "9199999#{Faker::Number.unique.number(digits: 5)}" }
    type {'EmailAccount'}
    activated {"true"}
    first_name {"kunal"}
    last_name {"jain"}
  end
  factory :email, :class => AccountBlock::EmailAccount do
    email  { Faker::Internet.free_email}
    type {'EmailAccount'}
  end
  factory :email_otp, :class => AccountBlock::EmailOtp do
    email  { Faker::Internet.free_email}
    # type {'EmailAccount'}
     # activated {"true"}
  end
  factory :sms_otp, class: AccountBlock::SmsOtp do
    full_phone_number { "9199999#{Faker::Number.unique.number(digits: 5)}" }
    activated { false }
    # email  { Faker::Internet.free_email}
  end
end
