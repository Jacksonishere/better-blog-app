Rails.application.routes.draw do
  resources :posts

  #users
  get '/register', to: 'users#new'
  resources :users, only: [:create]

  #create session
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  #if the user successfully signs in, we want to go to the create action to create a session.
  resources :sessions, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
