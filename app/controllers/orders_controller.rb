class OrdersController < ApplicationController

  def new
    @items = Item.get_items(current_user.id)
    @item_count = Order.get_item_count(@items)
    @item_total_price, @delivery_fee, @cash_on_delivery_fee, @order_total_price = Order.get_order_each_prices(@items, @item_count)
  end

  def create
  end

end
