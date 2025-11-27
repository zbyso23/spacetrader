class Player::Cell::MarketItem < Trailblazer::Cell
  def show
    render
  end

  def market_price
    model[:market_price]
  end

  def player
    model[:player]
  end

  def inventory
    model[:inventory]
  end

  def player_inventory
    @player_inventory ||= inventory.find { |inv| inv.good_id == market_price.good.id }
  end

  def max_sell_quantity
    player_inventory&.quantity || 0
  end

  def can_sell?
    player_inventory && player_inventory.quantity > 0
  end
end