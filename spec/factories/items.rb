FactoryBot.define do
  factory :item do
    name { '牛丼セット' }
    image { 'https://www.pakutaso.com/shared/img/thumb/gyudon458A7164_TP_V.jpg' }
    price { 2000 }
    description { '牛丼セット×10セット' }
    is_hidden { false }
    display_order { 1 }
  end

  trait :item_hidden do
    is_hidden { true }
  end
end
