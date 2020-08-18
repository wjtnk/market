class Item < ApplicationRecord

  # キャッシュからItemを取得
  # user_idをkeyとして、{itemのid => itemの個数}
  # e.g){ 1 => 500, 2 => 100, 3 =>10} の時、itemのidが1のものが500個、itemのidが2のものが100個、itemのidが3のもの10個
  def self.get_item_info(user_id)
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

end