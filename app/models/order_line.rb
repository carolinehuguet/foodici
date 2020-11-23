class OrderLine < ApplicationRecord
  belongs_to :product
  belongs_to :ordershop
end
