class Player::Cell::Travel < Trailblazer::Cell
  def show
    render
  end

  def player
    model[:player]
  end

  def available_routes
    model[:available_routes]
  end
end