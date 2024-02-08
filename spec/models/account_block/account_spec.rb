require 'rails_helper'

RSpec.describe AccountBlock::Account, type: :model do
  context "association test" do
  	it "should has_one blacklist_user " do
  		t = AccountBlock::Account.reflect_on_association(:blacklist_user)
  		expect(t.macro).to eq(:has_one)
  	end	
    it "should has_many books " do
      t = AccountBlock::Account.reflect_on_association(:books)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many user_offers " do
      t = AccountBlock::Account.reflect_on_association(:user_offers)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many orders " do
      t = AccountBlock::Account.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many addresses " do
      t = AccountBlock::Account.reflect_on_association(:addresses)
      expect(t.macro).to eq(:has_many)
    end 
    it "should has_many order_transactions " do
      t = AccountBlock::Account.reflect_on_association(:order_transactions)
      expect(t.macro).to eq(:has_many)
    end 

    it { should define_enum_for(:status).with_values(['regular', 'suspended', 'deleted']) }
 
    it { is_expected.to callback(:attach_shareable_link_to_account).after(:create) }

    it "returns Account scope activated true" do
      user1 = AccountBlock::Account.create(activated: true)
      user2 = AccountBlock::Account.create(activated: false)
      user3 = AccountBlock::Account.create(activated: false)
      expect(AccountBlock::Account.active).to include(user1)
      expect(AccountBlock::Account.active).to_not include(user2, user3)
    end
    it "returns Account scope for vaild status" do
      user1 = AccountBlock::Account.create(status: 'regular')
      user2 = AccountBlock::Account.create(status: 'suspended')
      expect(AccountBlock::Account.existing_accounts).to include(user1)
    end
  end
end