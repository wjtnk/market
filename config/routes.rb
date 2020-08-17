Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'items#index'

  get  "items/:item_id/buy" , to: "items#buy" , as: 'items_buy'
end
