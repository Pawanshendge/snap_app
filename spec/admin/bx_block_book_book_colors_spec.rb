require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::BookColorsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    @account = FactoryBot.create(:account)
    sign_in @admin
    @book_color = FactoryBot.create(:book_color)
  end
  describe "book_color#new" do
    let(:params) do {
      book_color: @book_color.book_color,
      logo_color: @book_color.logo_color
    }
    end
    it "create book_color" do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#index" do
    it "show all the book_color" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end