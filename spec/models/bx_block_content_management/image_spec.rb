require 'rails_helper'

RSpec.describe BxBlockContentManagement::Image, type: :model do
  context "association test" do
  	it "should belongs_to attached_item " do
  		t = BxBlockContentManagement::Image.reflect_on_association(:attached_item)
  		expect(t.macro).to eq(:belongs_to)
  	end	 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:image) }  
    end
  end
end