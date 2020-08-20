class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :delivery_fee
      t.integer :cash_on_delivery_fee
      t.integer :total_price
      t.integer :address
      t.integer :deliver_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
