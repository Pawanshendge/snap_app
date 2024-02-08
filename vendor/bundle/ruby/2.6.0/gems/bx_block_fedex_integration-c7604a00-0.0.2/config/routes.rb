BxBlockFedexIntegration::Engine.routes.draw do
  resources :shipments, only: [:create, :show]
end
