class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).order(id: "DESC")
  end

  def new
    @carts = Cart.where(user_id: current_user.id)
    @item_count = Cart.get_item_count(@carts)

    @item_total_price = Order.get_item_total_price(@carts)
    @delivery_fee = Order.get_delivery_fee(@item_count)
    @cash_on_delivery_fee = Order.get_cash_on_delivery_fee(@item_total_price)
    @order_total_price = Order.get_order_total_price(@item_total_price, @delivery_fee, @cash_on_delivery_fee)
  end

  # カート(キャッシュ)に保存している商品を購入
  def create
    Order.create_order(current_user.id, params[:address], params[:deliver_time])
    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
