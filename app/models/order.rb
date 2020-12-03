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
    origin = order.starting_address
    shops = []

    order.order_shops.each do |order_shop|
      shops << order_shop.shop
    end

    if shops.length == 1
      destination = "#{shops.first.latitude}, #{shops.first.longitude}"
    elsif shops.length == 2
      waypoints = "#{shops.first.latitude}, #{shops.first.longitude}"
      destination = "#{shops.last.latitude}, #{shops.last.longitude}"
    else
      destination = "#{shops.last.latitude}, #{shops.last.longitude}"
      first_waypoints = shops.pop
      raw_waypoints = []
      shops.each do |shop|
        raw_waypoints << "#{shop.latitude}, #{shop.longitude}"
      end
      waypoints = raw_waypoints.join('|')
    end

    url = "https://www.google.com/maps/dir/?api=1&origin=#{origin}&waypoints=#{waypoints}&destination=#{destination}&dir_action=navigate"
    return url
  end
end
