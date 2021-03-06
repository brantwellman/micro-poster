Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activates, only: [:edit]
  resources :password_resets,   only: [:edit, :new, :create, :update]
  resources :microposts,        only: [:create, :destroy]
  resources :relationships,     only: [:create, :destroy]
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
