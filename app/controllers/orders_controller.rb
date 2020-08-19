class OrdersController < ApplicationController

  def new
    @items = Item.get_items(current_user.id)
  end

  def create
  end

end
