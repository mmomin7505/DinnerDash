class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_and_belongs_to_many :categories
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image



  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 }
end
