class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.string :description
      t.boolean :is_hidden, default: false
      t.integer :display_order

      t.timestamps
    end
  end
end
