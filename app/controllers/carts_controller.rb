class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.get_items(current_user.id)
  end

end
