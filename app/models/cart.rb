class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # カートにitemを追加
  def self.add_item(user_id, item_id)
    cart = self.find_by(user_id: user_id, item_id:item_id)

    if cart.blank?
      # itemが新しいものだったら「count: 1」として新規作成してreturn
      self.create!(
          user_id: user_id,
          item_id: item_id,
          count: 1
      )
      return
    end

    # countに+1して更新
    cart.update(count: cart.count += 1)
  end

  # カートからItemを削除
  def self.remove_item(user_id, item_id)
    cart = self.find_by(user_id: user_id, item_id:item_id)

    # cart.countが2個以上ある時はcountを1つ減らしてreturn
    if cart.count >= 2
      cart.update(count: cart.count -= 1)
      return
    end

    cart.destroy
  end

end
