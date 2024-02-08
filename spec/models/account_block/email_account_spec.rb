require 'rails_helper'

RSpec.describe AccountBlock::EmailAccount, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      email_otp = AccountBlock::EmailAccount.create()
      expect(email_otp.errors.messages[:email]).to eq(["can't be blank"])
    end
  end
end
