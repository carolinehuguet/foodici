class Order < ApplicationRecord
  belongs_to :user
  has_many :order_shops

  validates :starting_address, presence: true
  validates :status, uniqueness: { scope: :user_id }, if: :cart?
  validates :status, inclusion: { in: ["cart", "pending", "fulfilled"] }

  monetize :total_price_cents

  def cart?
    return status == "cart"
  end
end
