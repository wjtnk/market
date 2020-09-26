class Item < ApplicationRecord

  has_many :purchase_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  scope :displayable, -> { where(is_hidden: false).order(:display_order) }

end