FactoryBot.define do
  factory :cart_item do
    association :cart
    association :item
    count 1
  end
end
