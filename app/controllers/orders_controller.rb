class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.where(user_id: current_user.id).order(id: "DESC")
  end

  def new
    @cart = current_user.cart
  end

  # カートに保存している商品を購入
  def create
    current_user.purchase(params[:address], params[:deliver_time])
    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
