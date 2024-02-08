require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::UsersController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    @account = FactoryBot.create(:account)
    sign_in @admin
  end
  describe "user#new" do
    let(:params) do {
    	user_name: @account.user_name,
      activated: @account.activated
    }
    end
    it "create account" do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#index" do
    it "show all the users" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#show" do
    it "show user" do
      get :show, params: {id: @account.id}
      expect(response).to have_http_status(200)
    end
  end
end