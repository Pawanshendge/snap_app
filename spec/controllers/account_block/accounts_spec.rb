require 'rails_helper'
RSpec.describe "AccountBlock::Accounts", type: :request do
  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }


  before :context do 
    @account = FactoryBot.create(:account)
    @account_login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @failed_account = {"data": {"type": "email_account","attributes": {"email": @account.email}}}

    @email_otp = FactoryBot.create(:email_otp, email: "deepali@gmail.com")
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@email_otp.id)
    @verify_otp_params = { token: @login_token, format: :json }

    @sms_otp = FactoryBot.create(:sms_otp, full_phone_number: "9199999#{Faker::Number.unique.number(digits: 5)}")
    @sms_token = BuilderJsonWebToken::JsonWebToken.encode(@sms_otp.id)
    @verify_sms_params = { token: @sms_token, format: :json }
    @custom_email = FactoryBot.create(:custom_email)

    @otp_params =  {"data": {"type": "email_account","attributes": {"pin": @email_otp.pin ,"email": @email_otp}}} 
    @failed_otp_params =  {"data": {"type": "email_account","attributes": {"pin": "","email": @email_otp}}} 
    @create_otp_params =  {"data": {"type": "email_account","attributes": {"email": "deepali@gmail.com"}}}   
    @create_smsotp_params =  {"data": {"type": "sms_account","attributes": {"email": "deepali@gmail.com","full_phone_number": "9199999#{Faker::Number.unique.number(digits: 5)}"}}} 
    @verify_smsotp_params =  {"data": {"type": "sms_account","attributes": {"full_phone_number": "9199999#{Faker::Number.unique.number(digits: 5)}","pin": @sms_otp.pin}}}     
    @failed_smsotp_params =  {"data": {"type": "sms_account","attributes": {"full_phone_number": "9199999#{Faker::Number.unique.number(digits: 5)}","pin": ""}}}  
  end

  context 'Account Create' do
    # it 'get_user_details_with_email_account' do
    #   @login_params_data =  {"data": {"type": "email_account","attributes": {"email": "deepali@gmail.com"}}}
    #   post '/account_block/accounts', params: @login_params_data
    #   expect(response.status).to eq 201
    #   puts JSON.parse(response.body)
    # end
    it 'get_user_details_with_email_account' do
      @login_params_data =  {"data": {"type": "email_account","attributes": {"email": "deepaligmail.com"}}} 
      post '/account_block/accounts', params: @login_params_data
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"account"=>"Email invalid or Already present please use another email"}]})
      puts JSON.parse(response.body)
    end         
    # it 'get_user_details_with_social_account' do
    #   @sms_params_data =  {"data": {"type": "social_account","attributes": {"email": "deepali@gmail.com"}}}  
    #   post '/account_block/accounts', params: @sms_params_data
    #   expect(response.status).to eq 201
    #   puts JSON.parse(response.body)
    # end     
    it 'get_user_details_failed' do
      @params_data =  {"data": {"type": "account","attributes": {"account": "deepali@gmail.com"}}} 
      post '/account_block/accounts', params: @params_data
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"account"=>"Invalid Account Type"}]})
      puts JSON.parse(response.body)
    end        
  end 

  context 'Get User Details' do
    it 'get_user_details' do
      get '/account_block/accounts/get_user_details', params: {token: @account_login_token}
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end    
    it 'get_user_details_failed' do
      get '/account_block/accounts/get_user_details', params: {token: @account_login_toke}
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"token"=>"Invalid token"}]})
      puts JSON.parse(response.body)
    end    
  end 

  context 'OTP Sent Successfully' do
    it 'Otp create' do
      post '/account_block/accounts/create_otp', params: @create_otp_params
      expect(response.status).to eq 201
      puts JSON.parse(response.body)
    end
    it 'Account already activated' do
      post '/account_block/accounts/create_otp', params: @failed_account
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"account"=>"Account already activated"}]})
      puts JSON.parse(response.body)
    end     
  end 

  context 'Otp Verify' do
    it 'verify otp' do
      post '/account_block/accounts/verify_otp', params: @verify_otp_params.merge(@otp_params)
      expect(response.status).to eq 201
      puts JSON.parse(response.body)
    end
    it 'Failed verify otp' do
      post '/account_block/accounts/verify_otp', params: @verify_otp_params.merge(@failed_otp_params)
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"pin"=>"Please enter a valid OTP"}]})
      puts JSON.parse(response.body)
    end    
  end

  context 'SMS OTP' do
    it 'SMS Otp create' do
      post '/account_block/accounts/create_sms_otp', { params: @create_smsotp_params }
      expect(response).to have_http_status(:created)
      puts JSON.parse(response.body)
    end    
    # it 'SMS Otp verify' do
    #   post '/account_block/accounts/verify_sms_otp', { params: @verify_sms_params.merge(@verify_smsotp_params) }
    #   expect(response.status).to eq 201
    #   puts JSON.parse(response.body)
    # end
    it 'Failed SMS Otp verify' do
      post '/account_block/accounts/verify_sms_otp', { params: @verify_sms_params.merge(@failed_smsotp_params) }
      expect(JSON.parse(response.body)).to eq({"errors"=>[{"pin"=>"Please enter a valid OTP"}]})
      puts JSON.parse(response.body)
    end 
  end  

  context 'Reset OTP' do
    it 'Reset Otp' do
      post '/account_block/accounts/resend_otp', { params: @create_smsotp_params }
      expect(response).to have_http_status(:created)
      puts JSON.parse(response.body)
    end        
  end

  context 'upload_profile_photo' do
    it 'create profile' do
      @params =  {"data": {"attributes": {"first_name": "first_name","last_name": "last_name", "full_name": "full_name", "profile_picture": "null"}}}
      put '/account_block/accounts/upload_profile_photo', headers: {token: @account_login_token}, params: @params
     data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
    it 'get profile' do
      get '/account_block/accounts/get_user_profile', headers: {token: @account_login_token}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end

  context 'get_dashboard_media' do
    it 'get dashboard media' do
      get '/account_block/accounts/get_dashboard_media', params: {token: @account_login_token}
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end
  end

end