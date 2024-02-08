BxBlockShoppingCart::Engine.routes.draw do
  resources :customer_appointments, :only => [] do
    collection do
      get :customer_orders
    end
    member do
      put :update_notification_setting
    end
  end

  resources :service_provider_appointments, :only => [] do
    collection do
      get :filter_order
      put :start_order
      put :finish_order
    end
  end
  resources :orders, :only => [:create, :show]

  resources :availabilities, only: [] do
    collection  do
      get :get_booked_time_slots
    end
  end
end
