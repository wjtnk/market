class Cart < ApplicationRecord
  belongs_to :user

  def add_item(item_id)
    cart_item = self.cart_item.find_by(item: item_id)

    if cart_item.blank?
      # itemが新しいものだったら「count: 1」として新規作成
      cart_item.count = 1
      cart_item.save!
    else
      # countに+1して更新
      cart_item.update(count: self.count += 1)
    end

  end

  def remove_item(item_id)
    cart_item = self.cart_item.find_by(item: item_id)
    # cart.countが2個以上ある時はcountを1つ減らす
    if cart_item.count >= 2
      cart_item.update(count: self.count -= 1)
    else
      cart_item.destroy
    end
  end

  # カートに入っている商品(購入する商品)の合計個数を返す
  def item_count
    count = 0
    carts.each do |cart|
      count += cart.count
    end
    count
  end

  # 商品合計金額
  def item_total_price
    item_total_price = 0
    carts.each do |cart|
      item_total_price += cart.item.price * cart.count
    end
    item_total_price
  end

  #送料算出(5商品ごとに600円追加)
  def delivery_fee
    ( (item_count / 6) + 1 ) * 600
  end

  #代引き手数料算出
  def cash_on_delivery_fee
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
    ((item_total_price + delivery_fee + cash_on_delivery_fee) * 1.08).floor
  end

end
