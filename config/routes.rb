Myflix::Application.routes.draw do
  root "videos#home"
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  get 'signin', to: "sessions#new"
  post 'loggedin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy"
  get "my_queue", to: "queue_items#index"
  post "update_queue", to: "queue_items#update_queue"
  resources :users
  resources :queue_items, only: [:create, :destroy]
  resources :videos, except: [:index] do 
    collection do 
      get 'search', to: "videos#search"
    end 
    resources :reviews, only: [:create]
  end 
end
