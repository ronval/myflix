Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  resources :videos, except: [:index] do 
    collection do 
      get 'search', to: "videos#search"
    end 
  end 
end
