Browser::Application.routes.draw do
  root :to => 'images#index'
  
  resources :images do
    post :tag
  end
  
  resources :tags
end
