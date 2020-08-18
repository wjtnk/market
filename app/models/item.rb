class Item < ApplicationRecord

  # キャッシュからItemを取得
  def self.get_item_info(user_id)
    cart = Rails.cache.read(user_id)
    return cart.blank? ? [] : Item.where(id: cart[:items])
  end

  # キャッシュにitemを追加
  # user_idをkeyとして、{itemのid => itemの個数}
  # e.g){ 1 => 500, 2 => 100, 3 =>10} の時、itemのidが1のものが500個、itemのidが2のものが100個、itemのidが3のもの10個
  def self.add_item(user_id, item_id)
    cart = Rails.cache.read(user_id)

    # itemが何もなかったら新たに配列に書き込み
    if cart.blank?
      Rails.cache.write(user_id, {item_id => 1})
      return
    end

    # itemが新しいものだったら
    if cart[item_id].blank?
      cart[item_id] = 1
      Rails.cache.write(user_id, cart)
      return
    end

    cart[item_id] +=  1
    Rails.cache.write(user_id, cart)

  end

end