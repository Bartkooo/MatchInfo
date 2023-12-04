Rails.application.routes.draw do
  resources :leagues, only: [:show]
  resources :teams, only: [:show]
  root 'leagues#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
