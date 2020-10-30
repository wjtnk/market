# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  [
    {
      email: 'sample@sample.com',
      password: 'password',
      name: 'sample太郎',
      default_address: '新宿区西新宿2-8-1',
      default_deliver_time: 1,
    },
  ]
)

Cart.create!(
  [
    {
      user_id: user[0].id,
    },
  ]
)

Item.create!(
  [
    {
      name: '牛丼セット(10セット)',
      image: 'https://www.pakutaso.com/shared/img/thumb/gyudon458A7164_TP_V.jpg',
      price: 2000,
      description: '牛丼セット×10セット!!',
      is_hidden: false,
      display_order: 1,
    },
    {
      name: 'お寿司セット(4人前)',
      image: 'https://www.pakutaso.com/shared/img/thumb/MOK_unitotoro_TP_V.jpg',
      price: 3000,
      description: 'お寿司セット4人前です',
      is_hidden: false,
      display_order: 2,
    },
    {
      name: 'ホットケーキ粉(1kg)',
      image: 'https://www.pakutaso.com/shared/img/thumb/PP_hotcake_TP_V.jpg',
      price: 500,
      description: '大容量ホットケーキ粉',
      is_hidden: false,
      display_order: 3,
    },
    {
      name: '冷凍鯛焼き(10個入り)',
      image: 'https://www.pakutaso.com/shared/img/thumb/YUKI1211B1142_TP_V.jpg',
      price: 800,
      description: '冷凍鯛焼き10個入り',
      is_hidden: true,
      display_order: 4,
    },
  ]
)
