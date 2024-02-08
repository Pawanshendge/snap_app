require 'rails_helper'
RSpec.describe "BxBlockAddress::Addresses", type: :request do
  before do
    @address = FactoryBot.create(:address)
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")
    @order = FactoryBot.create(:order, account_id: @account.id)
    @address1 = FactoryBot.create(:address, order_id: @order.id)
    @auth_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @headers = {
      "token" => @auth_token,
      "Content-Type" => "application/json"
    }
  end
  context 'get_address' do
    it "List of all addresses" do
      get "/bx_block_address/addresses/get_address", params: { token: @auth_token,  order_id: @order.id }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end

    it "Address not present" do
      get "/bx_block_address/addresses/get_address", params: { token: @auth_token}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(404)
    end

    it "get all addresse" do
      get "/bx_block_address/addresses", params: { token: @auth_token }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end

  context 'address destroy ' do
    it "Delete_address" do
      delete "/bx_block_address/addresses/#{@address.id}",  params: { token: @auth_token }
      expect(response.body).to include("address destroyed successfully")
    end
    it "Address not Delete" do
      delete "/bx_block_address/addresses/0",  params: { token: @auth_token }
      expect(response.body).to include("Address not found")
    end
  end
 
  context 'Created' do
    it "Address Created Successfully" do
      post "/bx_block_address/addresses/address_create", params: { token: @auth_token, address: @address.address, state: @address.state ,email_address: @address.email_address, pincode: @address.pincode, phone_number: @address.phone_number, full_name: @address.full_name, city: @address.city }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
    it "Address not created" do
      post "/bx_block_address/addresses/address_create", params: { token: @auth_token }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(404)
    end
    it "create address" do
      post "/bx_block_address/addresses", params: { token: @auth_token, addressble_id: @account.id,order_id: @order.id, address: @address.address, state: @address.state ,email_address: @address.email_address, pincode: @address.pincode, phone_number: @address.phone_number, full_name: @address.full_name, city: @address.city, share_with_family_member: true}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
  end
  
  context ' update_address' do
    it "update_address" do
      put "/bx_block_address/addresses/#{@address.id}", params: { token: @auth_token, email_address: @address.email_address}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
    it "address not found Something went wrong." do
      put "/bx_block_address/addresses/#{@address.id}", params: { token: @auth_token, email_address: ""}
      expect(response.body).to include("Something went wrong. Please try again")
    end
    it "update_address_successfully" do
      put "/bx_block_address/addresses/update_address", params: { token: @auth_token, order_id: @order.id, email_address: @address.email_address, share_with_family_member: true}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
    it "Address not found, Please try again" do
      put "/bx_block_address/addresses/update_address", params: { token: @auth_token, email_address: "", share_with_family_member: false}
      expect(response.body).to include("Address not found, Please try again")
    end
  end
end
 before do
  @role = BxBlockRolesPermissions::Role.find_or_create_by(name: "driver") }
  @account = FactoryBot.create(:account, role_id: role.id) 
  @token = BuilderJsonWebToken::JsonWebToken.decode(user.id)
  @transaction =  FactoryBot.create(:transaction)
end
  describe 'POST #dashboard_details' do
    context 'with valid date range' do
      it 'returns dashboard details' do
        request_data = {
          'startDateTime' => '2023-01-01T00:00:00Z',
          'endDateTime' => '2023-01-10T23:59:59Z'
        }
request.headers[:token]=@token
        post :dashboard_details, body: request_data.to_json, format: :json

    expect(response).to have_http_status(:ok)
  end
end
