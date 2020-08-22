class ItemsController < ApplicationController
  before_action :authenticate_user!,only:[:add, :remove]

  def index
    @items = Item.where(is_hidden: false).order(:display_order)
  end

  def add
    Item.add_item(current_user.id, params[:id])
    redirect_to carts_path, notice: "カートに商品を追加しました!!"
  end

  def remove
    Item.remove_item(current_user.id, params[:id])
    redirect_back fallback_location: root_path, notice: "カートから商品を削除しました!!"
  end

end
