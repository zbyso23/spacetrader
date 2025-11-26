class Good < ApplicationRecord
  has_many :market_prices, dependent: :destroy
  has_many :planets, through: :market_prices
  has_many :player_inventories, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end