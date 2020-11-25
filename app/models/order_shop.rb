class OrderShop < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  has_many :order_lines

  validates :subtotal_price_cents, presence: true
   # validates :status, inclusion: { in: ["accepted", "denied", "pending", "cancelled"] }

  monetize :price_cents
end
