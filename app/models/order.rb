class Order < ApplicationRecord

  has_many :purchase_items, dependent: :destroy
  belongs_to :user

  # 商品の個数を算出する
  def self.get_item_count(items)
    count = 0
    items.values.each do |item|
      count += item
    end
    count
  end

  # 注文作成に必要な金額をそれぞれ返す
  # return 商品の合計数,送料,代引き手数料,商品合計金額
  def self.get_order_each_prices(items, item_count)
    item_total_price = self.get_item_total_price(items)
    delivery_fee = self.get_delivery_fee(item_count)
    cash_on_delivery_fee = self.get_cash_on_delivery_fee(item_total_price)
    order_total_price = self.get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)
    return item_total_price, delivery_fee, cash_on_delivery_fee, order_total_price
  end

  private

  #商品合計金額
  def self.get_item_total_price(items)
    item_total_price = 0
    items.each do |item_id, count|
      item_total_price += Item.find(item_id).price * count
    end
    item_total_price
  end

  #送料算出(5商品ごとに600円追加)
  def self.get_delivery_fee(item_count)
    ( (item_count / 6) + 1 ) * 600
  end

  #代引き手数料算出
  def self.get_cash_on_delivery_fee(item_total_price)
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
  def self.get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)
    (item_total_price + delivery_fee + cash_on_delivery_fee * 1.08).floor
  end

end
