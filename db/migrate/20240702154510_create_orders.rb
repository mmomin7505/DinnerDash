class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :status, default: 'ordered'
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :completed_at
      t.datetime :canceled_at

      t.timestamps
    end
    add_foreign_key :orders,:users
    add_index :orders, :user_id         
  end
end
