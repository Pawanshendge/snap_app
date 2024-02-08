require 'rails_helper'

RSpec.describe BxBlockProfile::PublicationPatent, type: :model do
  context "association test" do
    it "should belongs_to profile " do
      t = BxBlockProfile::Course.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end