require 'rails_helper'
RSpec.describe "BxBlockStories::Blog", type: :request do
  it 'All Active Story' do
    get "/bx_block_stories/blogs/active_blogs"
    expect(response).to have_http_status(:ok)
    puts JSON.parse(response.body)
  end 
  context('reset password api specs') do  
      it 'returns status 200' do
        get "/bx_block_stories/blogs/6?url=hello-blog"
        expect(response).to have_http_status(:ok)
        puts JSON.parse(response.body)
      end 
      it 'returns status 422' do
        get "/bx_block_stories/blogs/6?url=hello-blog1"
        expect(JSON.parse(response.body)).to eq({"errors"=>[{"message"=>"Blog not found"}]})
        puts JSON.parse(response.body)
      end
  end
end