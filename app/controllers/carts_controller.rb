class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.get_items(current_user.id)
  end

  def add
    Item.add_item(current_user.id, params[:item_id])
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    Item.remove_item(current_user.id, params[:item_id])
    flash[:notice] = "カートから商品を削除しました!!"
    redirect_back fallback_location: root_path
  end

end
