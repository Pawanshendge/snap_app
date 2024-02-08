require 'rails_helper'

RSpec.describe BxBlockLanguageOptions::ContentLanguage, type: :model do
  context "validations test" do
    it "should belongs_to account " do
      t = BxBlockLanguageOptions::ContentLanguage.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end
    it "should belongs_to language" do
      t = BxBlockLanguageOptions::ContentLanguage.reflect_on_association(:language)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end