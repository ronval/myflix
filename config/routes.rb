require 'sidekiq/web'

Myflix::Application.routes.draw do
  root "videos#home"
  mount Sidekiq::Web, at: "/sidekiq"
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  get 'signin', to: "sessions#new"
  post 'loggedin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy"
  get "my_queue", to: "queue_items#index"
  post "update_queue", to: "queue_items#update_queue"
  get 'people', to: "relationships#index"
  get "forgot_password", to: "forgot_password#new"
  get "forgot_password_confirmation", to: "forgot_password#confirm"
  get "expired_token", to: "password_reset#expired_token"
  get "register/:token", to: "users#new_with_invitation_token", as:"register_with_token"
  resources :invitations, only:[:new, :create]
  resources :password_reset, only:[:show, :create]
  resources :forgot_password, only:[:create]
  resources :relationships, only:[:destroy, :create]
  resources :users
  resources :queue_items, only: [:create, :destroy]
  resources :videos, except: [:index] do 
    collection do 
      get 'search', to: "videos#search"
    end 
    resources :reviews, only: [:create]
  end 

  namespace :admin do 
    resources :videos, only:[:new, :create]
  end 




end
