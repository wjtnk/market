class Item < ApplicationRecord

  # キャッシュからItemを取得
  def self.get_item_info(user_id)
    cart = Rails.cache.read(user_id)
    return cart.blank? ? [] : Item.where(id: cart[:items])
  end

  # キャッシュにitemを追加
  def self.add_item(user_id, item_id)

    cart = Rails.cache.read(user_id)
    item = Item.find(item_id)

    # itemがなかったら新たに配列に書き込み
    if cart.blank?
      Rails.cache.write(user_id, {"items": [item_id]})
      return
    end

    cart[:items].push(item_id)
    Rails.cache.write(user_id, {"items": cart[:items]})

  end

end
