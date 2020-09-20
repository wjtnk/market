class Item < ApplicationRecord

  has_many :purchase_items, dependent: :destroy

  scope :displayable, -> { where(is_hidden: false).order(:display_order) }

end