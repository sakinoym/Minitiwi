Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :likes
      get :privates
    end
  end

  resources :posts, only: [:create, :destroy, :update]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
