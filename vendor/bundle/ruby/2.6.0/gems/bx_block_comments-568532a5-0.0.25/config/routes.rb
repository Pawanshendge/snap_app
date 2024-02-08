# frozen_string_literal: true

BxBlockComments::Engine.routes.draw do
  if defined?(Rswag)
    mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
    mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  end

  resources :comments, only: %i[index show create update destroy] do
    collection do
      get :search
    end
  end
end
