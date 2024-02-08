BxBlockHelpCentre::Engine.routes.draw do
  resources :question_type, :only => [:index, :show, :create, :update, :destroy]
  resources :question_sub_type, :only => [:index, :show, :create, :update, :destroy]
  resources :question_answer, :only => [:index, :show, :create, :update, :destroy]
  resources :search_que_ans, :only => [:index]
end
