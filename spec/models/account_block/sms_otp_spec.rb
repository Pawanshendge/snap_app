require 'rails_helper'

RSpec.describe AccountBlock::SmsOtp, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      full_phone_number = AccountBlock::SmsOtp.create()
      expect(full_phone_number.errors.messages[:full_phone_number]).to eq(["Invalid or Unrecognized Phone Number", "can't be blank"])
    end   
    it { is_expected.to callback(:generate_pin_and_valid_date).before(:create) }
    it { is_expected.to callback(:parse_full_phone_number).before(:validation) }
    it { is_expected.to callback(:send_pin_via_sms).after(:create) }
  end
end
