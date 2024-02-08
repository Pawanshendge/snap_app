OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_APP_ID_PROD'], ENV['GOOGLE_APP_SECRET_PROD'], skip_jwt: true, provider_ignores_state: true
end
