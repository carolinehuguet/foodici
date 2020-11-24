class Order < ApplicationRecord
  belongs_to :user
  has_many :order_shops

  validates :starting_address, :total_price_cents, presence: true
  validates :status, uniqueness: { scope: :user_id }, if: :cart?
  # validates :status, inclusion: { in: ["accepted", "denied", "pending", "cancelled"] }

  def cart?
    return status == "cart"
  end
end
