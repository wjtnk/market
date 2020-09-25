class Cart < ApplicationRecord
  belongs_to :user

  def add
    if self.new_record?
      # itemが新しいものだったら「count: 1」として新規作成
      self.count = 1
      self.save!
    else
      # countに+1して更新
      self.update(count: self.count += 1)
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
