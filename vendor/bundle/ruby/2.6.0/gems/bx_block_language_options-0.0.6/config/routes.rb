BxBlockLanguageOptions::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)
  resources :languages, only: %i[index update] do
    collection do
      post 'set_app_language'
      get 'get_all_translations'
      get 'last_translation_time'
    end
  end
end
