require 'rails_helper'

RSpec.describe BxBlockContentManagement::Bookmark, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockContentManagement::Bookmark.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it "should belongs_to content " do
      t = BxBlockContentManagement::Bookmark.reflect_on_association(:content)
      expect(t.macro).to eq(:belongs_to)
    end 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:account_id) }
    end
  end
end
