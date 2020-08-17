class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def buy
    byebug
  end

end
