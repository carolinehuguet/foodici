class OrderLine < ApplicationRecord
  belongs_to :product
  belongs_to :order_shop
  has_one :shop, through: :order_shop

  validates :subtotal_price_cents, :quantity, presence: true

  monetize :subtotal_price_cents
  before_save :update_subtotal

  def update_subtotal
  	self.subtotal_price_cents = quantity * product.price_cents
  end
end
