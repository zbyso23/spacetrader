class Player::Cell::PlayerInfo < Trailblazer::Cell
  def show
    render
  end

  def player
    model[:player]
  end

  def planet
    model[:planet]
  end
end