module AccountBlock
  class SmsOtp < ApplicationRecord
    self.table_name = :sms_otps

    include Wisper::Publisher

    before_validation :parse_full_phone_number

    before_create :generate_pin_and_valid_date
    after_create :send_pin_via_sms

    validate :valid_phone_number
    validates :full_phone_number, presence: true

    attr_reader :phone

    def generate_pin_and_valid_date
      self.pin         = rand(1_000..9_999)
      self.valid_until = Time.current + 5.minutes
      self.activated = false
    end

    def send_pin_via_sms
      message = "Please use OTP - #{self.pin} to login to your Whitebook account.
OTP valid for 2 minutes.
Do not share this OTP with anyone for security reasons."
      txt     = BxBlockSms::SendSms.new("+#{self.full_phone_number}", message)
      txt.call
    end

    private

    def parse_full_phone_number
      @phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = @phone.sanitized
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Invalid or Unrecognized Phone Number")
      end
    end
  end
end
