class Product < ApplicationRecord
  belongs_to :shop
  has_one_attached :photo

  validates :name, :price_cents, :amount, :unit, presence: true
  validates :organic, inclusion: { in: [true, false] }
end
