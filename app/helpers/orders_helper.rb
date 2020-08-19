module OrdersHelper

  # 商品の個数を算出する
  def get_item_count(items)
    count = 0
    items.values.each do |item|
      count += item
    end
    count
  end

  #送料算出(5商品ごとに600円追加)
  def get_delivery_fee(items)
    item_count = get_item_count(items)
    ( (item_count / 6) + 1 ) * 600
  end

  #商品合計金額
  def get_item_total_price(items)
    item_total_price = 0
    items.each do |item_id, count|
      item_total_price += get_item(item_id).price * count
    end
    item_total_price
  end

  def get_cash_on_delivery_fee(items)
    999
  end

  def get_order_total_price(items)
    999
  end

end
