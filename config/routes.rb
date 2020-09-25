Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'items#index'

  resources :items, only: [:index]

  resources :orders, only: [:index, :new, :create]

  resources :carts, only: [:index, :new, :create] do
    member do
      post :add_item
      delete :remove_item
    end
  end

end
