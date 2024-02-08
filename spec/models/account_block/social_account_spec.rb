require 'rails_helper'

RSpec.describe AccountBlock::SocialAccount, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      email_otp = AccountBlock::SocialAccount.create()
      expect(email_otp.errors.messages[:email]).to eq(["can't be blank"])
    end
    describe 'ensure uniqueness of some attributes' do
    it { should validate_uniqueness_of(:email) }
    end
    it { is_expected.to callback(:set_active).after(:validation) }
  end
end