class Planet < ApplicationRecord
  has_many :market_prices, dependent: :destroy
  has_many :goods, through: :market_prices
  has_many :players, foreign_key: :current_planet_id
  
  has_many :outgoing_routes, class_name: 'TravelRoute', foreign_key: :from_planet_id
  has_many :incoming_routes, class_name: 'TravelRoute', foreign_key: :to_planet_id
  
  validates :name, presence: true, uniqueness: true
  validates :planet_type, inclusion: { in: %w[planet moon] }
end