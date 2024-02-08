require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::StoriesController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    sign_in @admin
    @stories = FactoryBot.create(:stories)
  end
  describe "Post#new" do
    let(:params) do {
      story_type: @stories.story_type,
      title: @stories.title,
      description: @stories.description
    }
    end
    it "create stories" do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#index" do
    it "show all the stories" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "Get#show" do
    it "show story" do
      get :show, params: {id: @stories.id}
      expect(response).to have_http_status(200)
    end
  end

end
