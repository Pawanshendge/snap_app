BxBlockOrderManagement::Engine.routes.draw do
  resources :carts, only: [:create]
  resources :orders, only: [:create, :show]
  resources :addresses, only: [:index, :create, :show, :update, :destroy]
  put 'orders/:order_id/cancel_order', to: 'orders#cancel_order'
  get 'orders', to: 'orders#my_orders'
  put 'orders/:order_id/add_address_to_order', to: 'orders#add_address_to_order'
  put 'orders/:order_id/update_payment', to: 'orders#update_payment_source'
  post 'orders/:cart_id/apply_coupon', to: 'orders#apply_coupon'

  post '/create_delivery_address', to: 'admin#delivery_address_create'
end
