Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'application#welcome'
  
  get '/show', to: 'users#show'
  get '/signup', to: 'users#new'
  post '/signup-attempt', to: 'users#create'
  delete '/destroy', to: 'users#destroy' 

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signout', to: 'sessions#destroy'
  resources :essays
  resources :poems
  resources :blogs

  resources :users, only: [:new, :create, :index, :show, :destroy]
end
