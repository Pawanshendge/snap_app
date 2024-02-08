BxBlockCouponCg::Engine.routes.draw do
  resources :coupon_code_generator, only: [
    :index, :show, :create, :update, :destroy
  ]
end
