class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy

  def purchase(address, deliver_time)
    ActiveRecord::Base.transaction do

      #注文を作成
      order = Order.create!(
          delivery_fee: order_info.delivery_fee,
          cash_on_delivery_fee: order_info.cash_on_delivery_fee,
          total_price: order_info.order_total_price,
          address: address,
          deliver_time: deliver_time,
          user: self
      )

      # 商品の購入履歴を記入
      order_info.carts.each do |cart|
        PurchaseItem.create!(
            item_id: cart.item_id,
            order_id: order.id,
            count: cart.count
        )
      end

      # 購入後はカートに入っている商品を削除
      order_info.carts.destroy_all
    end
  end

  def order_info
    # if @order_info
    #   @order_info
    # else
    #   @order_info = OrderInfo.new(self.id)
    #   @order_info
    # end

    # @order_info = (@order_info || OrderInfo.new(self.id))

    @order_info ||= OrderInfo.new(self.id)
  end
end
