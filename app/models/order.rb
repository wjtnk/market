class Order < ApplicationRecord

  has_many :purchase_items, dependent: :destroy
  belongs_to :user

  DELIVER_TIME = { "8-12" => 1, "12-14" => 2, "14-16" => 3, "16-18" => 4, "18-20" => 5, "20-21" => 6 }

  # 商品合計金額
  def get_item_total_price(carts)
    item_total_price = 0
    carts.each do |cart|
      item_total_price += cart.item.price * cart.count
    end
    item_total_price
  end

  #送料算出(5商品ごとに600円追加)
  def get_delivery_fee(item_count)
    ( (item_count / 6) + 1 ) * 600
  end

  #代引き手数料算出
  def get_cash_on_delivery_fee(item_total_price)
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
  def get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)
    ((item_total_price + delivery_fee + cash_on_delivery_fee) * 1.08).floor
  end

end
