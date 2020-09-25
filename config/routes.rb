Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'items#index'

  resources :items, only: [:index]

  resources :orders, only: [:index, :new, :create]

  resources :carts, only: [:index, :new, :create] do
    collection do
      delete :remove
    end
  end

end

# user <- OrderInfo <- Cart -> item # 現状
# user <- cart <- cart_item -> item
# user <- order <- purchase_item -> item

# class Cart
#   import PriceCalculator
# end

# class Order
#   import PriceCalculator
# end

# module PriceCalculator
#   def get_item_count
#   end
# end
