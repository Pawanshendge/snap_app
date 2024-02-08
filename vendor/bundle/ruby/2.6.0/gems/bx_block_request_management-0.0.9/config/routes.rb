BxBlockRequestManagement::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)

  resources :requests, only: [:index, :create, :update, :show, :destroy] do
    collection do
      get :sent
      get :received
    end
    member do
      put :review
    end
  end
end
