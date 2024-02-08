require 'rails_helper'
RSpec.describe "BxBlockStories::Story", type: :request do
  before(:each) do |example|
    @stories = FactoryBot.create(:stories)
    # @token = BuilderJsonWebToken.encode(@account.id)
  end
  it 'All Active Story' do
    get "/bx_block_stories/stories/active_stories"
    expect(response).to have_http_status(:ok)
    puts JSON.parse(response.body)
  end  
  it 'deleted Active Story' do
    delete "/bx_block_stories/stories/#{@stories.id}"
    expect(response).to have_http_status(:ok)
    puts JSON.parse(response.body)
  end
  it 'returns status 422' do
    delete "/bx_block_stories/stories/5"
    expect(response.body).to eq("")
    puts "Invalid ID"
  end
end