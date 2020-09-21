class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = Cart.where(user_id: current_user.id)
  end

  def create
    cart = Cart.find_or_initialize_by(user_id: current_user.id, item_id: params[:item_id])
    cart.add
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    cart = Cart.find_by(user_id: current_user.id, item_id: params[:item_id])
    cart.remove
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
