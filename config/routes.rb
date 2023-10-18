Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        resources :books, only: [:index, :create, :show, :update, :destroy]
    end
  end

  resources :sessions, only: [:create]
  resources :user, only: [:create] do
    member do
      get 'show', to: 'user#show'
      get 'get_wishlist', to: 'wishlist#index'
      post 'add_to_wishlist', to: 'wishlist#add'
      delete 'remove_from_wishlist', to: 'wishlist#remove'
      get 'get_readlist', to: 'readlist#index'
      post 'add_to_readlist', to: 'readlist#add'
      delete 'remove_from_readlist', to: 'readlist#remove'
    end
  end

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root "static#index"
end
