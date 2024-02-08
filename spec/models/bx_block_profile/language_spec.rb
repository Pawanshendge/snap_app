require 'rails_helper'

RSpec.describe BxBlockProfile::Language, type: :model do
  context "association test" do
    it "should belongs_to profile " do
      t = BxBlockProfile::Language.reflect_on_association(:profile)
      expect(t.macro).to eq(:belongs_to)
    end  
    # it { should validate_presence_of(:profile_id) }
  end 
end 