class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.get_item_info(current_user.id)
  end

  def add
    Item.add_item(current_user.id, params[:item_id])

    puts "#########################"
    puts Rails.cache.read(current_user.id)
    puts "#########################"

    flash[:notice] = "カートに商品を追加しました!!"
    redirect_back(fallback_location: root_path)
  end

end
