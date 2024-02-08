require 'rails_helper'

RSpec.describe BxBlockBook::AdditionalPricePerPage, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      additional_price = BxBlockBook::AdditionalPricePerPage.create()
      expect(additional_price.errors.messages[:additional_price]).to eq(["can't be blank"])
    end
  end
end
