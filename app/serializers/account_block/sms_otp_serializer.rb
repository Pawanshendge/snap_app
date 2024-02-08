module AccountBlock
  class SmsOtpSerializer < BuilderBase::BaseSerializer
    attributes :full_phone_number, :created_at
    attributes :pin
  end
end
