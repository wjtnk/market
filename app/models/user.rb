class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  def purchase(address, deliver_time)
    carts      = Cart.where(user_id: id)

    order = Order.new
    item_count           = order.get_item_count(carts)
    delivery_fee         = order.get_delivery_fee(item_count)
    item_total_price     = order.get_item_total_price(carts)
    cash_on_delivery_fee = order.get_cash_on_delivery_fee(item_total_price)
    order_total_price    = order.get_order_total_price(item_total_price, delivery_fee, cash_on_delivery_fee)

    ActiveRecord::Base.transaction do

      #注文を作成
      order = Order.create!(
          delivery_fee: delivery_fee,
          cash_on_delivery_fee: cash_on_delivery_fee,
          total_price: order_total_price,
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
