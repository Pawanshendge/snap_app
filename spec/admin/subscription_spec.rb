require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::SubscriptionsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    @subscription = FactoryBot.create(:subscription)
    sign_in @admin
  end
  describe "Get#index" do
    it "show all the subscription" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end