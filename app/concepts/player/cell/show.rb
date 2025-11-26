class Player::Cell::Show < Trailblazer::Cell
  def show
    render
  end

  def player
    model[:player]
  end

  def planet
    model[:planet]
  end

  def market_prices
    model[:market_prices]
  end

  def available_routes
    model[:available_routes]
  end

  def inventory
    model[:inventory]
  end
end