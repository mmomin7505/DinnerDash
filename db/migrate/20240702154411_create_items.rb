class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :photo

      t.timestamps
    end
    add_index :items, :title, unique: true
  end
end
