class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items, @total_price = Item.get_item_info(current_user.id)
  end

  def add
    Item.add_item(current_user.id, params[:item_id])
    redirect_back(fallback_location: root_path)
  end

end
