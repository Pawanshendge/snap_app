require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::UserOffersController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    @user_offer = FactoryBot.create(:user_offers)
    sign_in @admin
  end
  describe "Get#index" do
    it "show user_offer" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end