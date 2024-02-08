require 'rails_helper'

RSpec.describe BxBlockLike::Like, type: :model do
  context "association test" do
    it "should belongs_to likeable " do
      t = BxBlockLike::Like.reflect_on_association(:likeable)
      expect(t.macro).to eq(:belongs_to)
    end 
    it { is_expected.to callback(:create_notification).after(:create) }
  end
end