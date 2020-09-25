class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(id: "DESC")
  end

  def new
    # @order_info = OrderInfo.new(current_user.id)
    @order_info = current_user.order_info
  end

  # カートに保存している商品を購入
  def create
    current_user.purchase(params[:address], params[:deliver_time])
    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
