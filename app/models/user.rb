class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
  has_many :orders
  has_many :order_items, through: :orders
       
  validates :email, presence: true
  validates :full_name, presence: true
  validates :display_name, length: { in: 2..32 }

  def admin?
    role == 'admin'
  end
end
