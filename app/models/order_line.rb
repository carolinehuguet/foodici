class OrderLine < ApplicationRecord
  belongs_to :product
  belongs_to :order_shop

  validates :subtotal_price_cents, :quantity, presence: true

  monetize :price_cents
end
