class ItemsController < ApplicationController
  before_action :authenticate_user!,only:[:add, :remove]

  def index
    @items = Item.displayable
  end

  def add
    Cart.add_item(current_user.id, params[:id])
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    Cart.remove_item(current_user.id, params[:id])
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
