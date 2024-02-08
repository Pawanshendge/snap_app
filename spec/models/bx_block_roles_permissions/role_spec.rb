require 'rails_helper'

RSpec.describe BxBlockRolesPermissions::Role, type: :model do
  context "association test" do
    it "should has_many accounts " do
      t = BxBlockRolesPermissions::Role.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end     
    # it { should validate_uniqueness_of(:name) }
  end 
end 
