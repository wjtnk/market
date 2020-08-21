Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'items#index'
  post "items/:item_id/add" , to: "carts#add" , as: 'item_add_to_cart'
  delete "items/:item_id/remove" , to: "carts#remove" , as: 'item_remove_from_cart'
  resources :carts, only: [:index]
  resources :orders, only: [:index, :new, :create]
end
