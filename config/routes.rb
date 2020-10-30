Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'items#index'

  resources :items, only: [:index]

  resources :orders, only: %i[index new create]

  resources :carts, only: %i[index new] do
    collection do
      post :add_item
      delete :remove_item
    end
  end
end
