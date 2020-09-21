class OrderInfo

  attr_accessor :user_id, :carts, :item_count, :item_total_price, :delivery_fee, :cash_on_delivery_fee, :order_total_price

  def initialize(user_id)
    @user_id = user_id
    @carts   = Cart.where(user_id: user_id)

    @item_count = get_item_count

    @item_total_price     = get_item_total_price
    @delivery_fee         = get_delivery_fee
    @cash_on_delivery_fee = get_cash_on_delivery_fee
    @order_total_price    = get_order_total_price
  end

  # カートに入っている商品(購入する商品)の合計個数を返す
  def get_item_count
    count = 0
    carts.each do |cart|
      count += cart.count
    end
    count
  end

  # 商品合計金額
  def get_item_total_price
    item_total_price = 0
    carts.each do |cart|
      item_total_price += cart.item.price * cart.count
    end
    item_total_price
  end

  #送料算出(5商品ごとに600円追加)
  def get_delivery_fee
    ( (item_count / 6) + 1 ) * 600
  end

  #代引き手数料算出
  def get_cash_on_delivery_fee
    if 0 <= item_total_price && item_total_price < 10000
      300
    elsif 10000 <= item_total_price && item_total_price < 30000
      400
    elsif 30000 <= item_total_price && item_total_price < 100000
      600
    elsif 100000 < item_total_price
      1000
    else
      0
    end
  end

  # 商品の税込み合計金額
  def get_order_total_price
    ((item_total_price + delivery_fee + cash_on_delivery_fee) * 1.08).floor
  end

end
