class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.get_item(current_user.id)
  end

  def add
    Item.add_item(current_user.id, params[:item_id])
    redirect_back(fallback_location: root_path)
  end

end
