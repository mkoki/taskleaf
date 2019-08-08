Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    get 'start_time' => 'tasks#start_time'
  end
end
