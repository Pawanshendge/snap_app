require 'rails_helper'

RSpec.describe BxBlockProfile::Degree, type: :model do
  context "association test" do
    it "should has_many degree_educational_qualifications " do
      t = BxBlockProfile::Degree.reflect_on_association(:degree_educational_qualifications)
      expect(t.macro).to eq(:has_many)
    end     
  end
end