class Category < ApplicationRecord
  has_and_belongs_to_many :items
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
end
