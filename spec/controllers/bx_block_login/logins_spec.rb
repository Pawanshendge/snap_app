require 'rails_helper'

RSpec.describe "BxBlockLogin::Logins", type: :request do
  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }


  before :context do 
    @account = FactoryBot.create(:account)
    @account_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @account_login_token = { token: @account_token, format: :json }
    @account_login = {"data": {"type": "email_account","attributes": {"email": @account.email}}} 

    @email_otp = FactoryBot.create(:email_otp, email: @account.email)
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@email_otp.id)
    @verify_otp_params = { token: @login_token, format: :json }

    @sms_otp = FactoryBot.create(:sms_otp, full_phone_number: @account.full_phone_number)
    @sms_token = BuilderJsonWebToken::JsonWebToken.encode(@sms_otp.id)
    @verify_sms_params = { token: @sms_token, format: :json }

    @otp_params =  {"data": {"type": "email_account","attributes": {"pin": @email_otp.pin ,"email": @account.email}}} 
    @failed_otp_params =  {"data": {"type": "email_account","attributes": {"pin": "","email": @account.email}}} 
    @create_otp_params =  {"data": {"type": "email_account","attributes": {"email": @account.email}}}   
    @failed_create_otp_params =  {"data": {"type": "email_account","attributes": {"email": ""}}}   
    @failed_login_params =  {"data": {"type": "email_account","attributes": {"email": "deepaligmail.com"}}}
    @create_smsemail_otp_params =  {"data": {"type": "email_account","attributes": {"email": @account.email, "full_phone_number": @account.full_phone_number}}} 

    @create_smsotp_params =  {"data": {"type": "sms_account","attributes": {"full_phone_number": @account.full_phone_number}}}
    @smsotp_params =  {"data": {"attributes": {"pin": @sms_otp.pin, "full_phone_number": @account.full_phone_number}}}    
    @failed_smsotp_params =  {"data": {"type": "sms_account","attributes": {"pin": "", "full_phone_number": @account.full_phone_number}}}
    @failed_create_smsotp_params =  {"data": {"type": "sms_account","attributes": {"full_phone_number": ""}}}

  end

  context 'Login Successfully' do
    it 'login Successfully ' do
      post '/bx_block_login/logins', params: @account_login_token.merge(@account_login)
      expect(response.status).to eq(200)
      puts JSON.parse(response.body)
    end      
    it 'Failed login' do
      post '/bx_block_login/logins', params: @failed_login_params.merge(@verify_otp_params)
      expect(response.body).to eq("{\"errors\":[{\"failed_login\":\"Account not found, or not activated\"}]}")
      puts JSON.parse(response.body)
    end      
  end 
  
  context 'Create Otp Login' do
    it 'create email login otp Successfully' do
      post '/bx_block_login/logins/create_otp_login', params: @verify_otp_params.merge(@create_otp_params)
      expect(response.status).to eq(201)
      puts JSON.parse(response.body)
    end  
    it 'create sms login otp Successfully' do
      post '/bx_block_login/logins/create_otp_login', params: @verify_sms_params.merge(@create_smsotp_params)
      expect(response.status).to eq(201)
      puts JSON.parse(response.body)
    end     
    it 'create sms login otp Unsuccessfully' do
      post '/bx_block_login/logins/create_otp_login', params: @verify_sms_params.merge(@failed_create_smsotp_params)
      expect(response.body).to eq("{\"errors\":[{\"account\":\"Account not registerd\"}]}")
      puts JSON.parse(response.body)
    end     
    it 'create sms_eamil login otp Successfully' do
      post '/bx_block_login/logins/create_otp_login', params: @verify_otp_params.merge(@create_smsemail_otp_params)
      expect(response.status).to eq(201)
      puts JSON.parse(response.body)
    end      
    it 'Create email login otp Unsuccessfully' do
      post '/bx_block_login/logins/create_otp_login', params: @verify_otp_params.merge(@failed_create_otp_params)
      expect(response.body).to eq("{\"errors\":[{\"account\":\"Account not registerd\"}]}")
      puts JSON.parse(response.body)
    end      
  end   

  context 'verify Otp Login' do
    it 'verify email login otp Successfully' do
      post '/bx_block_login/logins/verify_otp_login', params: @verify_otp_params.merge(@otp_params)
      expect(response.status).to eq(200)
      puts JSON.parse(response.body)
    end    
    # it 'verify sms login otp Successfully' do
    #   post '/account_block/accounts/verify_sms_otp', params: @verify_sms_params.merge(@smsotp_params)
    #   expect(response.status).to eq(200)
    #   puts JSON.parse(response.body)
    # end    
    it 'verify sms login otp Unsuccessfully' do
      post '/account_block/accounts/verify_sms_otp', params: @verify_sms_params.merge(@failed_smsotp_params)
      expect(response.body).to eq("{\"errors\":[{\"pin\":\"Please enter a valid OTP\"}]}")
      puts JSON.parse(response.body)
    end          
    it 'verify email login otp Unsuccessfully' do
      post '/bx_block_login/logins/verify_otp_login', params: @verify_otp_params.merge(@failed_otp_params)
      expect(response.body).to eq("{\"errors\":[{\"pin\":\"Please enter a valid OTP\"}]}")
      puts JSON.parse(response.body)
    end      
  end

end