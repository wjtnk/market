class PurchaseItem < ApplicationRecord

  belong_to :item
  belong_to :order

end
