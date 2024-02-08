require 'rails_helper'

RSpec.describe BxBlockContentManagement::ContentText, type: :model do
  context "association test" do
  	it "should has_many images " do
  		t = BxBlockContentManagement::ContentText.reflect_on_association(:images)
  		expect(t.macro).to eq(:has_many)
  	end	  
    it "should has_many videos " do
      t = BxBlockContentManagement::ContentText.reflect_on_association(:videos)
      expect(t.macro).to eq(:has_many)
    end  
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:headline) }
      it { should validate_presence_of(:content) }
    end 
    it{ should accept_nested_attributes_for :videos }   
    it{ should accept_nested_attributes_for :images }   
  end
end