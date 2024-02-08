require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::AboutUsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    sign_in @admin
    @about_us = FactoryBot.create(:about_us)
  end
  describe "about_us#new" do
    let(:params) do {
      content: @about_us.content,
      description: @about_us.description
    }
    end
    it "create about_us" do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#index" do
    it "show all the about_us" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#show" do
    it "show about_us" do
      get :show, params: {id: @about_us.id}
      expect(response).to have_http_status(200)
    end
  end
end