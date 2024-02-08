require 'rails_helper'
RSpec.describe "BxBlockDiscountsoffers::Offer", type: :request do
  before(:each) do |example|
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")   
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @verify_otp_params2 = { token: @login_token, format: :json }     
    @order = FactoryBot.create(:order, account_id: @account.id)
  end

  it 'NO offers' do
    get "/bx_block_discountsoffers/offers", headers: @verify_otp_params2
    data = JSON.parse(response.body)
    expect(JSON.parse(response.body)).to eq({"message"=>"Currently there are no offers." , "status" => 404})
  end 

  it 'Get Offers' do
    @offers = FactoryBot.create(:offers, coupon_type: "specfic_user", code: "offerscode", email: @account.email, active: true)
    @order.update(status:"placed")
    get "/bx_block_discountsoffers/offers", headers: @verify_otp_params2
    data = JSON.parse(response.body)  
    expect(response).to have_http_status(200)
  end  
end
