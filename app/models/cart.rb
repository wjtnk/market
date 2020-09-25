class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def add(amount)
    if self.new_record?
      # itemが新しいものだったら「count: 1」として新規作成
      self.count = amount
      self.save!
    else
      # countに+1して更新
      self.update(count: self.count += amount)
    end
  end

  def remove
    # cart.countが2個以上ある時はcountを1つ減らす
    if self.count >= 2
      self.update(count: self.count -= 1)
    else
      self.destroy
    end
  end

end


# TO BE
# class Cart < ApplicationRecord
#   def add_item(item_id, amount)
#     cart_item = self.cart_items.find_or_initialize_by(item_id: item_id)
#     cart_item.count += amount
#     cart_item.save!
#   end
# end
