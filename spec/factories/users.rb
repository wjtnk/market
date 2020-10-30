FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@example.com" }
    name { 'sample太郎' }
    default_address { '新宿区西新宿2-8-1' }
    default_deliver_time { 1 }
    password { 'password' }

    after(:create) do |user|
      FactoryBot.create(:cart, user: user)
    end
  end
end
