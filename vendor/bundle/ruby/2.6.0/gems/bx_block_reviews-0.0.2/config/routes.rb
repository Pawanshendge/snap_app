BxBlockReviews::Engine.routes.draw do
  resources :reviews, only: [:create, :index, :update]
end
