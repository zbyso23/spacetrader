class Player::Operation::Travel < Trailblazer::Operation
  step :find_player
  step :find_destination
  step :validate_travel
  step :process_travel
  step :update_market_prices

  def find_player(ctx, params:, **)
    ctx[:player] = Player.find_by(id: params[:player_id])
    ctx[:player].present?
  end

  def find_destination(ctx, params:, player:, **)
    destination = Planet.find_by(id: params[:destination_id])
    
    if destination.nil?
      ctx[:errors] = ["Destination not found"]
      return false
    end
    
    if destination.id == player.current_planet_id
      ctx[:errors] = ["You are already at #{destination.name}"]
      return false
    end
    
    ctx[:destination] = destination
    true
  end

  def validate_travel(ctx, player:, destination:, **)
    route = TravelRoute.find_by(
      from_planet_id: player.current_planet_id,
      to_planet_id: destination.id
    )
    
    if route.nil?
      ctx[:errors] = ["No route to #{destination.name}"]
      return false
    end
    
    if player.fuel < route.fuel_cost
      ctx[:errors] = ["Not enough fuel (need: #{route.fuel_cost}, have: #{player.fuel})"]
      return false
    end
    
    ctx[:route] = route
    true
  end

  def process_travel(ctx, player:, destination:, route:, **)
    ActiveRecord::Base.transaction do
      player.update!(
        current_planet_id: destination.id,
        fuel: player.fuel - route.fuel_cost
      )
    end
    true
  rescue => e
    ctx[:errors] = [e.message]
    false
  end

  def update_market_prices(ctx, destination:, **)
    # Změň ceny na trzích po cestování
    destination.market_prices.each do |mp|
      # Náhodná změna ceny ±10%
      change = rand(-10..10)
      new_buy_price = [mp.buy_price + (mp.buy_price * change / 100), 1].max
      new_sell_price = [mp.sell_price + (mp.sell_price * change / 100), 1].max
      
      # Měsíce mají variabilní kvalitu
      if destination.planet_type == 'moon' && !destination.has_fixed_quality?
        new_quality = rand(40..90)
        mp.update(buy_price: new_buy_price, sell_price: new_sell_price, quality: new_quality)
      else
        mp.update(buy_price: new_buy_price, sell_price: new_sell_price)
      end
    end
  end
end