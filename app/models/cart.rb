class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # カートに入っている商品(購入する商品)の合計個数を返す
  def self.get_item_count(carts)
    count = 0
    carts.each do |cart|
      count += cart.count
    end
    count
  end

end
