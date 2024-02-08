require 'rails_helper'

RSpec.describe BxBlockBook::Contribution, type: :model do
  context "association test" do
    it "should belongs_to service_provider " do
      t = BxBlockBook::Contribution.reflect_on_attachment(:images)
      expect(t.macro).to eq(:has_many_attached)
    end 
  end
end