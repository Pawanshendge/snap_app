BxBlockFavourites::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)

  resources :favourites, only: [:index, :create, :destroy]
end
