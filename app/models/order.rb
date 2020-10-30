class Order < ApplicationRecord
  has_many :purchase_items, dependent: :destroy
  belongs_to :user

  DELIVER_TIME = { '8-12' => 1, '12-14' => 2, '14-16' => 3, '16-18' => 4, '18-20' => 5, '20-21' => 6 }.freeze
end
