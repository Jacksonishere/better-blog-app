Rails.application.routes.draw do
  #resources is DSL, the routing system in rails. 
  #by passing in a block, we can recursively continue using DSL to define the routes.

  #for posts
  #nest comment routes into posts routes which uses the show_post route as the top level. This way, we dont need to have comments as a top level route cause that wouldn't make sense anyways, or write a bunch of, posts/:id/comment , ... etc.
  #pass in a block to resources method, 
  resources :posts do
    #by convention when we use nested routes, we're saying we want to do something related to the thing we're nesting inside of.
    #for example, when we nest this route, we're expecting to create a comment for a particular post
    resources :comments, only: [:create]
  end
  
  resources :likes, only: [:create, :destroy]
   

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
