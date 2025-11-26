class Player::Operation::Show < Trailblazer::Operation
  step :find_player
  step :load_location_data

  def find_player(ctx, params:, **)
    ctx[:player] = Player.includes(:current_planet, :user).find_by(id: params[:id])
    ctx[:player].present?
  end

  def load_location_data(ctx, player:, **)
    planet = player.current_planet
    
    ctx[:planet] = planet
    ctx[:market_prices] = planet.market_prices.includes(:good).order('goods.name')
    ctx[:available_routes] = planet.outgoing_routes.includes(:to_planet).order('planets.name')
    ctx[:inventory] = player.player_inventories.includes(:good).order('goods.name')
  end
end