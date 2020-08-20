class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: 1)
  end

  def new
    @items = Item.get_items(current_user.id)
    @item_count = Order.get_item_count(@items)
    @item_total_price, @delivery_fee, @cash_on_delivery_fee, @order_total_price = Order.get_order_each_prices(@items, @item_count)
  end

  # キャッシュに保存している商品を購入
  def create
    Item.purchase(current_user.id)
    flash[:notice] = "購入ありがとうございます!!"
    redirect_to root_path
  end

end
