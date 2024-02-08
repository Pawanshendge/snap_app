require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::OffersController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    sign_in @admin
    @offers = FactoryBot.create(:offers)
  end
  describe "Offers#new" do
    let(:params) do {
      coupon_type: @offers.coupon_type,
      title: @offers.title,
      description: @offers.description,
      code: @offers.code,
      discount_type: @discount_type
    }
    end
    it "create Offer" do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end
end