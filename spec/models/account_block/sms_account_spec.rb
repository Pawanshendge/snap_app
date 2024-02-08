require 'rails_helper'

RSpec.describe AccountBlock::SmsAccount, type: :model do
  context "validations test" do
    describe 'full_phone_number_uniqueness' do
      it { should validate_uniqueness_of(:full_phone_number) }
     end
  end
end

