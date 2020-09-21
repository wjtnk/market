class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :item

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

end
