require 'rails_helper'

RSpec.describe BxBlockLanguageOptions::Language, type: :model do
  context "association test" do
    it "should has_many contents_languages " do
      t = BxBlockLanguageOptions::Language.reflect_on_association(:contents_languages)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many accounts " do
      t = BxBlockLanguageOptions::Language.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end   
    it { should validate_presence_of(:name) }  
    it { is_expected.to callback(:update_available_locales).after(:commit) }
  end
end