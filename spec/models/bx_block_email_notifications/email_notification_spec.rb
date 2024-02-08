require 'rails_helper'

RSpec.describe BxBlockEmailNotifications::EmailNotification, type: :model do
  context "association test" do
  	it "should belongs_to notification " do
  		t = BxBlockEmailNotifications::EmailNotification.reflect_on_association(:notification)
  		expect(t.macro).to eq(:belongs_to)
  	end	
  end
end
