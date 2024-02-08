source 'https://rubygems.org'
source 'https://gem.fury.io/engineerai'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'active_storage_base64'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rspec-sonarqube-formatter', '~> 1.5'
end

group :test do
  gem 'mock_redis'
  gem 'simplecov', '<= 0.17'
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
end

group :development do
  gem 'dotenv-rails'
  gem "letter_opener"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bx_block_content_management', '0.0.2', require: 'bx_block_content_management'
gem 'bx_block_payments', '0.1.3'
# gem 'bx_block_bulk_uploading', '0.0.1', require: 'bx_block_bulk_uploading'
gem 'bx_block_login-3d0582b5', '0.0.10', require: 'bx_block_login'
gem 'bx_block_forgot_password-4de8968b', '0.0.6', require: 'bx_block_forgot_password'
gem 'account_block', '0.0.29'
gem 'bx_block_shopping_cart-9ec30a1c', '0.0.2', require: 'bx_block_shopping_cart'
gem 'bx_block_order_management-674a3e38', '0.0.5', require: 'bx_block_order_management'
gem 'bx_block_dashboard-9a14cb77', '0.0.3', require: 'bx_block_dashboard'
gem 'bx_block_admin', '0.0.10'
# gem 'rails_admin'
gem 'bx_block_roles_permissions-c50949d0', '0.0.6', require: 'bx_block_roles_permissions'
gem 'bx_block_profile', '0.0.8', require: 'bx_block_profile'
gem 'bx_block_profile_bio', '0.1.5'
gem 'bx_block_settings-5412d427', '0.0.3', require: 'bx_block_settings'
gem 'bx_block_notifications-a22eb801', '0.0.3', require: 'bx_block_notifications'
gem 'bx_block_push_notifications-c0f9e9b7', '0.0.7', require: 'bx_block_push_notifications'
gem 'bx_block_email_notifications', '0.0.3'
gem 'bx_block_help_centre', '0.0.2'
gem 'bx_block_reviews', '0.0.2', require: 'bx_block_reviews'
gem 'bx_block_custom_form-63cd533b', '0.0.7', require: 'bx_block_custom_form'
gem 'bx_block_custom_user_subs', '0.0.7'
gem 'bx_block_payment_admin', '0.0.2'
gem 'builder_base', '0.0.43'

gem 'activeadmin'
gem 'arctic_admin'
gem 'activeadmin_addons'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
gem 'activeadmin_quill_editor'

gem 'active_admin_role'
gem 'activeadmin_json_editor'
gem 'active_admin_datetimepicker'
gem 'redis', '~> 4.8.0'
gem 'sidekiq_alive'
gem 'sidekiq', '~> 6.1.0'
gem "yabeda-prometheus"    # Base
gem "yabeda-rails"         #API endpoint monitoring
gem "yabeda-http_requests" #External request monitoring
gem "yabeda-puma-plugin"
gem 'yabeda-sidekiq'
gem 'bx_block_cors'
gem 'zeitwerk', '~> 2.5', '>= 2.5.1'
gem 'libreconv'
gem 'aws-sdk', '~> 3.0', '>= 3.0.1'
gem 'aws-sdk-s3', '~> 1.105', '>= 1.105.1'
gem 'base64', '~> 0.1.1'
gem 'tmpdir', '~> 0.1.2'
gem 'open-uri', '~> 0.2.0'
gem 'active_storage_validations'
gem 'razorpay'

# goggle auth
gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-google-oauth2'
gem 'jquery-minicolors-rails'
gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary'
# gem 'wkhtmltopdf-binary-edge', '~> 0.12.6.0'
gem 'streamio-ffmpeg'
# Cron jobs in Ruby
gem "sidekiq-cron"
gem 'nokogiri', '~> 1.10', '>= 1.10.8'
gem "mini_magick"
