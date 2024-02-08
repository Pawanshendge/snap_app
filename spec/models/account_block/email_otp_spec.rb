require 'rails_helper'

RSpec.describe AccountBlock::EmailOtp, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      email_otp = AccountBlock::EmailOtp.create()
      expect(email_otp.errors.messages[:email]).to eq(["Invalid email format", "can't be blank"])
    end
    it { is_expected.to callback(:generate_pin_and_valid_date).before(:create) }
  end
end
