require 'rails_helper'

RSpec.describe BxBlockContentManagement::ContentType, type: :model do
  context "association test" do
  	it "should has_many content " do
  		t = BxBlockContentManagement::ContentType.reflect_on_association(:contents)
  		expect(t.macro).to eq(:has_many)
  	end	  
    it "should has_and_belongs_to_many partners " do
      t = BxBlockContentManagement::ContentType.reflect_on_association(:partners)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end  
    it "ensure validate of some attributes" do
      content_type = BxBlockContentManagement::ContentType.create()
      expect(content_type.errors.messages[:name]).to eq(["can't be blank"])
    end
  end
end