require 'rails_helper'

RSpec.describe BxBlockAdmin::AboutUs, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      description = BxBlockAdmin::AboutUs.create()
      expect(description.errors.messages[:description]).to eq(["can't be blank"])
    end
  end
end