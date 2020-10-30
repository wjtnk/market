FactoryBot.define do
  factory :cart do
    association :user
    item_count { 0 }
    item_total_price { 0 }
    delivery_fee { 0 }
    cash_on_delivery_fee { 0 }
    order_total_price { 0 }
  end
end
