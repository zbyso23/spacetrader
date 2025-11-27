class Player::Cell::TravelRoute < Trailblazer::Cell
  def show
    render
  end

  def route
    model[:route]
  end

  def player
    model[:player]
  end

  def can_travel?
    player.fuel >= route.fuel_cost
  end
end