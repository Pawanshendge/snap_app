# require 'rails_helper'
# RSpec.describe "BxBlockLogin::Omniauth", type: :request do

#   describe 'POST #google_auth' do
#     before do
#       OmniAuth.config.mock_auth[:google_oauth2] = { "provider" => "google_oauth2",
#         "uid" => "100000000000000000000",
#         "info" => {
#           "name" => "John Smith",
#           "email" => "john@example.com",
#           "first_name" => "John",
#           "last_name" => "Smith",
#           "image" => "https://lh4.googleusercontent.com/photo.jpg",
#           "urls" => {
#             "google" => "https://plus.google.com/+JohnSmith"
#           }
#         } 
#       }
#     end

#     it 'login with google account' do
#       FactoryBot.create(:account, :email => 'bharat.sa@gmail.com')
#       post '/login_with_google', params:  {:email => 'bharat.sa@gmail.com'}
#       expect(response).to have_http_status :ok
#       expect(json_response[:meta][:message]).to eq 'Signed-in Successfully'
#     end
#   end

#   describe 'GET #failure' do

#     it 'login failed with social account' do
#       get '/auth/failure', params: {}
#       expect(response).to have_http_status :unprocessable_entity
#       expect(json_response[:errors]).to include "There was a problem signing you in. Please register or try signing in later"
#     end
#   end
# end
