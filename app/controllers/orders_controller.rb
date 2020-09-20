class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).order(id: "DESC")
  end

  def new
    @order = Order.new(user_id: current_user.id)
    @carts = @order.carts
  end

  # カートに保存している商品を購入
  def create
    order = Order.new(user_id: current_user.id)
    order.purchase(params[:address], params[:deliver_time])
    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
