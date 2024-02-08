require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::CustomEmailsController, type: :controller do
	render_views
	before(:each) do
		@admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
		@admin.save
		@custom_email = FactoryBot.create(:custom_email)
		sign_in @admin
	end

	describe "Get#index" do
		it "show all the custom_email" do
			get :index
			expect(response).to have_http_status(200)
		end
	end

	describe "user#new" do
			let(:params) do {
				title: @custom_email.title,
	    }
	  end
	  it "create custom_email" do
	  	post :new, params: params
	  	expect(response).to have_http_status(200)
	  end
	end

	describe "Get#show" do
		it "show custom_email" do
			get :show, params: {id: @custom_email.id}
			expect(response).to have_http_status(200)
		end
	end
end