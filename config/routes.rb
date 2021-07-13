Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :essays
  resources :users, only: [:new, :create, :index, :show]
  resources :essay_contributors
  resources :sessions, only: [:new, :create, :destroy]

  get '/signup', to: 'users#new'
  post '/signup-attempt', to: 'users#create'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
