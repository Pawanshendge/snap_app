require 'rails_helper'

RSpec.describe BxBlockContentManagement::Author, type: :model do
  context "association test" do
    it "should has_many contents " do
      t = BxBlockContentManagement::Author.reflect_on_association(:contents)
      expect(t.macro).to eq(:has_many)
    end 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:bio) }  
    end
    it "should has_one image " do
      t = BxBlockContentManagement::Author.reflect_on_association(:image)
      expect(t.macro).to eq(:has_one)
    end 
    it{ should accept_nested_attributes_for :image }    
  end
end