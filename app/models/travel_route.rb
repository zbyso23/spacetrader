class TravelRoute < ApplicationRecord
  belongs_to :from_planet, class_name: 'Planet'
  belongs_to :to_planet, class_name: 'Planet'
  
  validates :fuel_cost, :time_cost, presence: true, numericality: { greater_than: 0 }
  validate :cannot_travel_to_same_planet
  
  private
  
  def cannot_travel_to_same_planet
    if from_planet_id == to_planet_id
      errors.add(:to_planet, "cannot be the same as from_planet")
    end
  end
end