class MarketPrice < ApplicationRecord
  belongs_to :planet
  belongs_to :good
  
  validates :buy_price, :sell_price, :quality, :stock, presence: true
  validates :quality, inclusion: { in: 1..100 }
  validates :buy_price, :sell_price, :stock, numericality: { greater_than_or_equal_to: 0 }
end