class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  def purchase(address, deliver_time)
    carts      = Cart.where(user_id: id)

    ActiveRecord::Base.transaction do

      #注文を作成
      order = Order.create!(
          delivery_fee: 100,
          cash_on_delivery_fee: 100,
          total_price: 100,
          address: address,
          deliver_time: deliver_time,
          user: self
      )

      # 商品の購入履歴を記入
      carts.each do |cart|
        PurchaseItem.create!(
            item_id: cart.item_id,
            order_id: order.id,
            count: cart.count
        )
      end

      # 購入後はカートに入っている商品を削除
      carts.destroy_all
    end
  end

end
