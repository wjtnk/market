class Item < ApplicationRecord

  has_many :purchase_items, dependent: :destroy

  # キャッシュからItemを取得
  # user_idをkeyとして、{itemのid => itemの個数}
  # e.g){ 1 => 500, 2 => 100, 3 =>10} の時、itemのidが1のものが500個、itemのidが2のものが100個、itemのidが3のもの10個
  def self.get_items(user_id)
    items = Rails.cache.read(user_id)
    return items.blank? ? [] : items
  end

  # キャッシュにitemを追加
  # 追加する形式はget_item_infoメソッドを参照
  def self.add_item(user_id, item_id)
    item = Rails.cache.read(user_id)

    # itemが何もなかったら新たに配列に書き込み
    if item.blank?
      Rails.cache.write(user_id, {item_id => 1})
      return
    end

    # itemが新しいものだったら
    if item[item_id].blank?
      item[item_id] = 1
      Rails.cache.write(user_id, item)
      return
    end

    item[item_id] +=  1
    Rails.cache.write(user_id, item)

  end

  # 商品を購入
  def self.purchase(user_id)
    items = self.get_items(user_id)
    item_count = Order.get_item_count(items)
    item_total_price, delivery_fee, cash_on_delivery_fee, order_total_price = Order.get_order_each_prices(items, item_count)

    order = Order.create!(
        delivery_fee: delivery_fee,
        cash_on_delivery_fee: cash_on_delivery_fee,
        total_price: order_total_price,
        user_id: user_id
    )

    items.each do |item_id, count|
      PurchaseItem.create!(
          item_id: item_id,
          order_id: order.id,
          count: count
      )
    end

    # 購入後はキャッシュに入っている商品を削除
    Rails.cache.delete(user_id)
  end
    
end