require 'rails_helper'

RSpec.describe BxBlockNotifications::Notification, type: :model do
  context "association test" do
    it "should belongs_to account " do
      t = BxBlockNotifications::Notification.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end      
    it { should validate_presence_of(:headings) }     
    it { should validate_presence_of(:contents) }     
    it { should validate_presence_of(:account_id) }  
  end
end