class Cart < ApplicationRecord

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def purchase(address, deliver_time)

    ActiveRecord::Base.transaction do

      #注文を作成
      order = Order.create!(
          delivery_fee: self.delivery_fee,
          cash_on_delivery_fee: self.cash_on_delivery_fee,
          total_price: self.order_total_price,
          address: address,
          deliver_time: deliver_time,
          user: self.user
      )

      # 商品の購入履歴を記入
      self.cart_items.each do |cart_item|
        PurchaseItem.create!(
            item_id: cart_item.item.id,
            order_id: order.id,
            count: cart_item.count
        )
      end

      # 購入後はカートに入っている商品を削除
      self.cart_items.destroy_all

      self.recalculate_each_prices

    end
  end

  def add_item(item_id)
    cart_item = self.cart_items.find_by(item: item_id)

    if cart_item.blank?
      # itemが新しいものだったら「count: 1」として新規作成
      self.cart_items.create!(
          item_id: item_id,
          count: 1,
      )
    else
      # countに+1して更新
      cart_item.update(count: cart_item.count += 1)
    end

    self.recalculate_each_prices

  end

  def remove_item(item_id)
    cart_item = self.cart_items.find_by(item: item_id)
    # cart.countが2個以上ある時はcountを1つ減らす
    if cart_item.count >= 2
      cart_item.update(count: cart_item.count -= 1)
    else
      cart_item.destroy
    end

    self.recalculate_each_prices

  end
  
  # カート内の商品の送料などの料金を計算し直す
  def recalculate_each_prices
    self.update!(
        item_count: self.item_count,
        item_total_price: self.item_total_price,
        delivery_fee: self.delivery_fee,
        cash_on_delivery_fee: self.cash_on_delivery_fee,
        order_total_price: self.order_total_price
    )
  end

  # カートに入っている商品(購入する商品)の合計個数を返す
  def item_count
    self.cart_items.map do |cart_item|
      cart_item.count
    end.sum
  end

  # 商品合計金額
  def item_total_price
    item_total_price = 0
    self.cart_items.each do |cart|
      item_total_price += cart.item.price * cart.count
    end
    item_total_price
  end

  #送料算出(5商品ごとに600円追加)
  def delivery_fee
    ( (self.item_count / 6) + 1 ) * 600
  end

  #代引き手数料算出
  def cash_on_delivery_fee
    item_total_price = self.item_total_price

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
  def order_total_price
    ((self.item_total_price + self.delivery_fee + self.cash_on_delivery_fee) * 1.08).floor
  end

end
