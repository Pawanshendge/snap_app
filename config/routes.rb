Rails.application.routes.draw do
  require 'sidekiq/web'
  default_url_options :host => "http://localhost:3000"

  mount Sidekiq::Web => '/sidekiq'
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # post '/auth/:provider/callback', to: 'sessions#create'

  match '/auth/:provider/callback', to: 'bx_block_login/omniauth#success', via: [:post]

  # shirocket webhook
  post '/webhook/receive' => 'webhook#receive', format: :json

  get '/auth/failure', to: 'bx_block_login/omniauth#failure'

  get  '/about_us', to: 'bx_block_privacy_settings/about_us#show'
  get  '/privacy_policies', to: 'bx_block_privacy_settings/privacy_policies#show'
  get  '/return_and_refund', to: 'bx_block_privacy_settings/return_and_refund#show'
  get  '/terms_and_conditions', to: 'bx_block_privacy_settings/terms_and_conditions#show'
  get  '/faqs', to: 'bx_block_privacy_settings/question_answer#index'

  namespace :bx_block_login do
    resource :logins, only: :create do
      collection do
        post 'create_otp_login'
        post 'verify_otp_login'
        post 'verify_sms_login'
      end
    end
  end
  
  post "/signup" , to: "account_block/accounts#signup"
  post "/login" , to: "account_block/accounts#login"
  post '/logout', to: "account_block/accounts#logout"
  post '/upload', to: "account_block/accounts#upload"

  namespace :account_block do
    resource :accounts do
      collection do
        post 'create_otp'
        post 'verify_otp'
        post 'resend_otp'
        post 'create_sms_otp'
        post 'verify_sms_otp'
        put 'upload_profile_photo'
        get 'get_user_details'
        get :get_dashboard_media
        get 'get_user_profile'
      end
    end
  end

  namespace :bx_block_book do

    resources :invite_users do
      collection do 
        post :request_responses  
      end
    end

    resources :books do
      collection do
        get :share_book
        get :book_color
        get :get_book_size_price
        get :get_delivery_charge
        get :get_book_price
        get :get_image_limit
        get :get_user_link
        post :add_a_different_photo
        post :book_create
        post :book_create_new
        post :upload_image_through_url
        post :shuffle_photos
        post :crop_photo
        post :start_contributing_images
        post :get_contributed_images
        delete :delete_contributed_images
        put :book_update_new
        get :get_additional_price_per_page
        post :add_user_details
      end

      member do
        patch :replace_images
        get :download_pdf
        get :download_order
        get :bulk_download
        get :bulk_download_zip
      end
    end
    
    resources :presigned_uploads, only: :create
  end

  namespace :bx_block_gallery do
    resources :photos
  end

  namespace :bx_block_discountsoffers do
    resources :offers do
      collection do
        get :create_admin
      end
    end
  end
  
  namespace :bx_block_order_management do
    resources :orders do
      collection do
        post :create_order
        get :orders_list
        post :apply_coupon
        patch :remove_coupon
        delete :delete_image
        # put :cancel_order
        delete '/draft_order_delete/:id', to: '/bx_block_order_management/orders#draft_order_delete'
      end

      member do
        get :order_details
        put :update_order

      end
    end

    resources :shiprocket do
      collection do
        post :cancel_order
        get :get_order
        post :generate_manifest
        post :print_manifest
        post :generate_label
        post :generate_invoice
        post :return_order
        get :track_order
      end
    end
    get '/download_invoice/:id', to: 'shiprocket#download_invoice', as: :download_invoice
  end

  namespace :bx_block_address do
    resources :addresses do
      collection do
        get :get_address
        put :update_address
        post :address_create
      end
    end
  end

  namespace :bx_block_ordersummary do
    resources :order_summary do
      collection do
        get :get_order_details
        put :update_quantity
        put :add_gift_note
        patch :order_x2
        get :get_book_url_details
      end
    end
  end

  namespace :bx_block_attachment do
    resources :attachments do
      member do
        put :update_image
        delete :delete_image
      end
    end
  end

  namespace :bx_block_payment_razorpay do
    resources :razorpays do
      collection do
        get 'verify_signature'
        get 'order_details'
        get 'capture'
      end
    end
  end

  namespace :bx_block_stories do
     resources :stories do
      collection do 
        get :active_stories
      end
    end
    resources :blogs do
      collection do
        get :active_blogs
      end
    end
  end

  namespace :bx_block_custom_user_subs do
    resources :subscriptions
    resources :user_subscriptions 
  end  

  namespace :bx_block_referrals do
    resources :referrals do
      member do 
         put :add_referral
         get :get_user_referral
      end
      collection do
        post :create_referral
      end
    end
  end

end
