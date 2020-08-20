class OrdersController < ApplicationController

  def new
    @items = Item.get_items(current_user.id)
    @item_count = Order.get_item_count(@items)
    @item_total_price, @delivery_fee, @cash_on_delivery_fee, @order_total_price = Order.get_order_each_prices(@items, @item_count)
  end

  # キャッシュに保存している商品を購入
  def create
    items = Item.get_items(current_user.id)
    item_count = Order.get_item_count(items)
    item_total_price, delivery_fee, cash_on_delivery_fee, order_total_price = Order.get_order_each_prices(items, item_count)

    order = Order.create!(
        delivery_fee: delivery_fee,
        cash_on_delivery_fee: cash_on_delivery_fee,
        total_price: order_total_price,
        user_id: current_user.id
    )

    items.each do |item_id, count|
      PurchaseItem.create!(
          item_id: item_id,
          order_id: order.id,
          count: count
      )
    end

    # 購入後はキャッシュに入っている商品を削除
    Rails.cache.delete(current_user.id)

    flash[:notice] = "購入ありがとうございます"
    redirect_to root_path
  end

end
