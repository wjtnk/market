class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts
  end

  def add_item
    cart = current_user.carts.find(params[:id])
    cart.add_item(params[:item_id])
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove_item
    cart = current_user.carts.find(params[:id])
    cart.remove_item(params[:item_id])
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
