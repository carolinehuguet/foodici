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

  def itinerary(order)
    coordonates = []
    order.order_shops.each do |order_shop|
      shop_coordonates = "#{order_shop.shop.latitude},#{order_shop.shop.longitude}"
      coordonates << shop_coordonates
     end
    url = "https://www.google.com/maps/dir/?api=1&waypoints=#{coordonates.join('|')}"
    return url
  end
end
