class CreateCart < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.integer :item_count, null: false, default: 0
      t.integer :item_total_price, null: false, default: 0
      t.integer :delivery_fee, null: false, default: 0
      t.integer :cash_on_delivery_fee, null: false, default: 0
      t.integer :order_total_price, null: false, default: 0
      t.timestamps
    end
  end
end
