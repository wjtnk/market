class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = Cart.where(user_id: current_user.id)
  end

  def create
    Cart.add_item(current_user.id, params[:item_id])
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    Cart.remove_item(current_user.id, params[:item_id])
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
