class CategoriesItem < ActiveRecord::Migration[6.1]
  def change
    create_join_table :items, :categories do |t|
      t.index [:item_id, :category_id] 
    end
  end
end
