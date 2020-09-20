class Order < ApplicationRecord

  has_many :purchase_items, dependent: :destroy
  belongs_to :user

  DELIVER_TIME = { "8-12" => 1, "12-14" => 2, "14-16" => 3, "16-18" => 4, "18-20" => 5, "20-21" => 6 }

  # 商品を購入
  def self.create_order(user_id, address, deliver_time)
    ActiveRecord::Base.transaction do

      carts      = Cart.where(user_id: user_id)
      item_count = Cart.get_item_count(carts)

      item_total_price     = self.get_item_total_price(carts)
      delivery_fee         = self.get_delivery_fee(item_count)
      cash_on_delivery_fee = self.get_cash_on_delivery_fee(item_total_price)
      order_total_price    = self.get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)

      #注文を作成
      order = self.create!(
          delivery_fee: delivery_fee,
          cash_on_delivery_fee: cash_on_delivery_fee,
          total_price: order_total_price,
          address: address,
          deliver_time: deliver_time,
          user_id: user_id
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
  end

  # 商品合計金額
  def self.get_item_total_price(carts)
    item_total_price = 0
    carts.each do |cart|
      item_total_price += cart.item.price * cart.count
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
    ((item_total_price + delivery_fee + cash_on_delivery_fee) * 1.08).floor
  end

end
