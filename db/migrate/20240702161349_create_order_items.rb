class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false, foreign_key: true
      t.integer :item_id, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :items
    add_index :order_items, [:order_id, :item_id]
    end
end
