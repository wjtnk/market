class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = Cart.where(user_id: current_user.id)
  end

  def create
    cart = Cart.find_by(user_id: current_user.id, item_id: params[:item_id])

    if cart.blank?
      # itemが新しいものだったら「count: 1」として新規作成してreturn
      Cart.create!(user_id: current_user.id, item_id: params[:item_id], count: 1)
    else
      # countに+1して更新
      cart.update(count: cart.count += 1)
    end

    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    cart = Cart.find_by(user_id: current_user.id, item_id: params[:item_id])

    # cart.countが2個以上ある時はcountを1つ減らす
    if cart.count >= 2
      cart.update(count: cart.count -= 1)
    else
      cart.destroy
    end

    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
