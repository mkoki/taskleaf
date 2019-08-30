Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root 'tasks#index'
  
  resources :tasks do
    post :import, on: :collection
    
    member do
      post '/start_time', to: 'tasks#start_time'
      post '/end_time', to: 'tasks#end_time'
    end
  end

end
