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

  #代引き手数料算出
  def get_cash_on_delivery_fee(items)
    item_total_price = get_item_total_price(items)
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
  def get_order_total_price(items)
    get_delivery_fee(items) + get_item_total_price(items) + get_cash_on_delivery_fee(items) * 1.08
  end

end
