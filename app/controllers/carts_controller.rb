class CartsController < ApplicationController

  def add
    Rails.cache.write('city', 'Tokyo')
    Rails.cache.read('city')
  end

end
