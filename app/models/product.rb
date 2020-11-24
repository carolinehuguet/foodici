class Product < ApplicationRecord
  belongs_to :shop
  has_one_attached :photo

  validates :name, :amount, :unit, presence: true
  validates :organic, inclusion: { in: [true, false] }

  monetize :price_cents
end
