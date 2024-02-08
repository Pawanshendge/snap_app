BxBlockCoupons::Engine.routes.draw do
  resources :coupons, only: [:index] do
    collection do
      get :check_applicability
      get :get_refferal_coupon
    end
  end

  resources :special_offers, only: %i(show) do
    collection do
      get :get_service_provider
    end
  end
end
