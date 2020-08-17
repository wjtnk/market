# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
#     [
#         {
#             email: 'sample@sample.com',
#             password: 'password',
#             name: 'ren',
#             address: '新宿区西新宿2-8-1'
#         },
#     ]
# )

Item.create!(
    [
        {
            name: 'サンプルItem1',
            image: 'sample1.png',
            price: 1000,
            description: 'サンプルItem1の説明文',
            is_display: 1,
            display_order: 1
        },
        {
            name: 'サンプルItem2',
            image: 'sample2.png',
            price: 2000,
            description: 'サンプルItem2の説明文',
            is_display: 1,
            display_order: 2
        },
        {
            name: 'サンプルItem3',
            image: 'sample1.png',
            price: 3000,
            description: 'サンプルItem3の説明文',
            is_display: 1,
            display_order: 3
        }
    ]
)