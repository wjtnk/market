class CreateCart < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.integer :item_count
      t.integer :item_total_price
      t.integer :delivery_fee
      t.integer :cash_on_delivery_fee
      t.integer :order_total_price
      t.timestamps
    end
  end
end
