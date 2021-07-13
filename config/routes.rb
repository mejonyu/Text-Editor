Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :essays
  resources :users, only: [:new, :create, :index, :show]
  resources :essay_contributors
  resources :sessions, only: [:new, :create, :destroy]
end
