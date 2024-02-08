require 'rails_helper'

RSpec.describe BxBlockPushNotifications::PushNotification, type: :model do
  context "association test" do
    it "should belongs_to push_notificable " do
      t = BxBlockPushNotifications::PushNotification.reflect_on_association(:push_notificable)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockPushNotifications::PushNotification.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end  
    it { should validate_presence_of(:remarks) }
    it { is_expected.to callback(:send_push_notification).before(:create) }
  end 
end 