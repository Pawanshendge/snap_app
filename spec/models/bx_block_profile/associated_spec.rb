require 'rails_helper'

RSpec.describe BxBlockProfile::Associated, type: :model do
  context "association test" do
    it "should has_many associated_projects " do
      t = BxBlockProfile::Associated.reflect_on_association(:associated_projects)
      expect(t.macro).to eq(:has_many)
    end
  end
end 