Myflix::Application.routes.draw do
  root "videos#home"
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  get 'signin', to: "sessions#new"
  post 'loggedin', to: "sessions#create"
  delete '/signout', to: "sessions#destroy"
  resources :users
  resources :videos, except: [:index] do 
    collection do 
      get 'search', to: "videos#search"
    end 
  end 
end
