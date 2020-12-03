class Order < ApplicationRecord
  belongs_to :user
  has_many :order_shops, dependent: :destroy
  has_many :order_lines, through: :order_shops
  has_many :shops, through: :order_shops

  # enlevé pour pouvoir créer un order sans strating_address
  # validates :starting_address, presence: true
  validates :status, uniqueness: { scope: :user_id }, if: :cart?
  validates :status, inclusion: { in: ["cart", "pending", "fulfilled"] }

  monetize :total_price_cents
  monetize :amount_cents

  before_save :complete_order_shop

  def complete_order_shop
    if status == "pending"
      order_shops.each do |shop|
        statuses = [ "completed", "pending" ] 
        shop.update(status: satuses.sample)
      end
    end
  end

  def cart?
    return status == "cart"
  end

  def itinerary(order)
    origin = [48.112160, -1.677671]
    travelmode =
    shops = []

    order.order_shops.each do |order_shop|
      shops << order_shop.shop
    end

    sorted_shops = shops.sort_by{ |shop| shop.distance_from(origin) }

    sorted_coordinates = sorted_shops.map! do |sorted_shop|
      sorted_shop = "#{sorted_shop.latitude}, #{sorted_shop.longitude}"
    end

    url = "https://www.google.com/maps/dir/?api=1&waypoints=#{sorted_coordinates.join('|')}&dir_action=navigate"
    return url
  end
end
