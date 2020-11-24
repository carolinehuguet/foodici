class Shop < ApplicationRecord
  has_many :products
  has_many :order_shops

  validates :name, :address, :phone_number, :opening_hour, :closing_hour, :category, presence: true
  validates :opening_days, inclusion: { in: [1, 2, 3, 4, 5, 6, 7] }
end
