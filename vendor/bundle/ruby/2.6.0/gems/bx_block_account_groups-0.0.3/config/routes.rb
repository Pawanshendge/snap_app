BxBlockAccountGroups::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)

  resources :groups, only: [:index, :show, :create, :update, :destroy] do
    member do
      post :add_accounts
      post :remove_accounts
    end
  end
end
