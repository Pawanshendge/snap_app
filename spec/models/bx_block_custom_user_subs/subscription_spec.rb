require 'rails_helper'

RSpec.describe BxBlockCustomUserSubs::Subscription, type: :model do
  context "association test" do
    it "should has_many user_subscriptions " do
      t = BxBlockCustomUserSubs::Subscription.reflect_on_association(:user_subscriptions)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_many account " do
      t = BxBlockCustomUserSubs::Subscription.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end     
    it "should has_one_attached image " do
      t = BxBlockCustomUserSubs::Subscription.reflect_on_attachment(:image)
      expect(t.macro).to eq(:has_one_attached)
    end 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:valid_up_to) }
    end
  end
end
