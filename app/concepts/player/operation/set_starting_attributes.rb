class Player::Operation::SetStartingAttributes < Trailblazer::Operation
  step :assign_attributes

  def assign_attributes(_ctx, model:, **)
    starting_planet = Planet.find_by(name: 'Mars')
    model.current_planet = starting_planet
    model.fuel = 100
    model.credit = 1000
    model.reputation = 1
    true
  end
end
