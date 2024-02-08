require 'rails_helper'
RSpec.describe "BxBlockReferrals::ReferralUser", type: :request do

  before(:each) do |example|
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")
    @account2 = FactoryBot.create(:account, email: "deepali@gmail.com")   
    @login_token2 = BuilderJsonWebToken::JsonWebToken.encode(@account2.id)
    @verify_otp_params2 = { token: @login_token2, format: :json }     
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @verify_otp_params = { token: @login_token, format: :json } 
    @referral = FactoryBot.create(:referral_user, account_id: @account.id)   
    @referral_code = FactoryBot.create(:referral_user, account_id: @account.id)  
    @get_referral_detail_path = "/bx_block_referrals/referrals/:id/get_user_referral" 
    @create_ref_path = "/bx_block_referrals/referrals/create_referral"
    @add_ref_path = "/bx_block_referrals/referrals/:id/add_referral"
    @referral_code_last = BxBlockReferrals::ReferralUser.last.referral_code
 end

  context 'Get ReferralUser' do
    it "get referral user detail" do
      get @get_referral_detail_path,  headers: @verify_otp_params
      data = JSON.parse(response.body)
      puts data
    end    
    it "account referral not created" do
      get @get_referral_detail_path,  headers: @verify_otp_params2
      data = JSON.parse(response.body)
      puts data
    end    
  end 

  context 'Referral Create' do
    it "create new referral code" do
      post @create_ref_path,  headers: @verify_otp_params2
      data = JSON.parse(response.body)
      puts data
    end   
    it "create referral code" do
      post @create_ref_path,  headers: @verify_otp_params
      data = JSON.parse(response.body)
      puts data
    end       
  end

  context 'Referral Add' do
    it "add referral" do
      ref = @referral_code_last
      put @add_ref_path, headers: @verify_otp_params, params: {referral_code: ref}
      data = JSON.parse(response.body)
    end
     it "referral code not authorized" do
      ref = @referral_code_last
      put @add_ref_path, headers: @verify_otp_params, params: {referral_code: "ref"}
      data = JSON.parse(response.body)
      expect(JSON.parse(response.body)).to eq({"message"=>"referral code not authorized"})
      puts data
    end
  end
end
