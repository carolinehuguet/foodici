class Order < ApplicationRecord
  belongs_to :user
  has_many :order_shops
  has_many :order_lines, through: :order_shops

  # enlevé pour pouvoir créer un order sans strating_address
  # validates :starting_address, presence: true
  validates :status, uniqueness: { scope: :user_id }, if: :cart?
  validates :status, inclusion: { in: ["cart", "pending", "fulfilled"] }

  monetize :total_price_cents
  monetize :amount_cents

  def cart?
    return status == "cart"
  end
end
