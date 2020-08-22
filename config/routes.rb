Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'items#index'

  resources :items, only: [:index] do
    member do
      post :add
      delete :remove
    end
  end

  resources :carts, only: [:index]
  resources :orders, only: [:index, :new, :create]
end
