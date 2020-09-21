class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).order(id: "DESC")
  end

  def new
    @carts = Cart.where(user_id: current_user.id)

    order = Order.new
    @item_count           = order.get_item_count(@carts)
    @delivery_fee         = order.get_delivery_fee(@item_count)
    @item_total_price     = order.get_item_total_price(@carts)
    @cash_on_delivery_fee = order.get_cash_on_delivery_fee(@item_total_price)
    @order_total_price    = order.get_order_total_price(@item_total_price, @delivery_fee, @cash_on_delivery_fee)
  end

  # カートに保存している商品を購入
  def create
    current_user.purchase(params[:address], params[:deliver_time])
    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
