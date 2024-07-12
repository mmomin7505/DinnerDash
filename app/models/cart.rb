class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items

  def merge_session_cart(session_cart)
    session_cart.each do |item|
      cart_item = cart_items.find_or_initialize_by(item_id: item['item_id'])
      cart_item.quantity ||= 0
      cart_item.quantity += item['quantity'].to_i
      cart_item.save
    end
  end
end
