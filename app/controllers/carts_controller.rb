class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts
  end

  def create
    # user <- cart <- cart_item -> item だとしたら
    # current_user.cart.add_item(params[:item_id], params[:amount])

    cart = current_user.carts.find_or_initialize_by(item_id: params[:item_id])
    cart.add(params[:amount])

    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    cart = current_user.carts.find_by(item_id: params[:item_id])
    cart.remove
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
