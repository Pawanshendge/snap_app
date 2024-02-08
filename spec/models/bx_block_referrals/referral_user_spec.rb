require 'rails_helper'
RSpec.describe BxBlockReferrals::ReferralUser, type: :model do
  context "association test" do
    it "should belongs_to sender " do
      t = BxBlockReferrals::ReferralUser.reflect_on_association(:accounts)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end