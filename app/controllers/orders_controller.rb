class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).order(id: "DESC")
  end

  def new
    @carts      = Cart.where(user_id: current_user.id)
    @item_count = Cart.get_item_count(@carts)

    order = Order.new
    @item_total_price     = order.get_item_total_price(@carts)
    @delivery_fee         = order.get_delivery_fee(@item_count)
    @cash_on_delivery_fee = order.get_cash_on_delivery_fee(@item_total_price)
    @order_total_price    = order.get_order_total_price(@item_total_price, @delivery_fee, @cash_on_delivery_fee)
  end

  # カート(キャッシュ)に保存している商品を購入
  def create
    carts      = Cart.where(user_id: current_user.id)
    item_count = Cart.get_item_count(carts)

    order = Order.new
    item_total_price     = order.get_item_total_price(carts)
    delivery_fee         = order.get_delivery_fee(item_count)
    cash_on_delivery_fee = order.get_cash_on_delivery_fee(item_total_price)
    order_total_price    = order.get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)

    ActiveRecord::Base.transaction do

      #注文を作成
      order = Order.create!(
          delivery_fee: delivery_fee,
          cash_on_delivery_fee: cash_on_delivery_fee,
          total_price: order_total_price,
          address: params[:address],
          deliver_time: params[:deliver_time],
          user_id: current_user.id
      )

      # 商品の購入履歴を記入
      carts.each do |cart|
        PurchaseItem.create!(
            item_id: cart.item_id,
            order_id: order.id,
            count: cart.count
        )
      end

      # 購入後はカートに入っている商品を削除
      carts.destroy_all

    end

    redirect_to orders_path, notice: '購入ありがとうございます!!'
  end

end
