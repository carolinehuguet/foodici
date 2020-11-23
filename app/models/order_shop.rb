class OrderShop < ApplicationRecord
  belongs_to :order
  belongs_to :shop
end
