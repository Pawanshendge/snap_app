BxBlockPushNotifications::Engine.routes.draw do
  resources :push_notifications, only: [:index, :create, :update, :show]
end
