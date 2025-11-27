class Player::Operation::BuyGood < Trailblazer::Operation
  step :find_player
  step :find_market_price
  step :validate_purchase
  step :process_purchase
  step :update_market

  def find_player(ctx, params:, **)
    ctx[:player] = Player.find_by(id: params[:player_id])
    ctx[:player].present?
  end

  def find_market_price(ctx, params:, player:, **)
    ctx[:market_price] = MarketPrice.includes(:good, :planet).find_by(
      planet_id: player.current_planet_id,
      good_id: params[:good_id]
    )
    ctx[:market_price].present?
  end

  def validate_purchase(ctx, params:, player:, market_price:, **)
    quantity = params[:quantity].to_i
    
    ctx[:quantity] = quantity
    ctx[:errors] = []
    
    if quantity <= 0
      ctx[:errors] << "Quantity must be positive"
      return false
    end
    
    if quantity > market_price.stock
      ctx[:errors] << "Not enough stock (available: #{market_price.stock})"
      return false
    end
    
    total_cost = market_price.buy_price * quantity
    if player.credit < total_cost
      ctx[:errors] << "Not enough credits (need: #{total_cost}, have: #{player.credit})"
      return false
    end
    
    ctx[:total_cost] = total_cost
    true
  end

  def process_purchase(ctx, player:, market_price:, quantity:, total_cost:, **)
    ActiveRecord::Base.transaction do
      # Odečti kredity
      player.update!(credit: player.credit - total_cost)
      
      # Přidej do inventáře
      inventory = player.player_inventories.find_or_initialize_by(good_id: market_price.good_id)
      
      if inventory.persisted?
        # Zprůměruj kvalitu
        total_quantity = inventory.quantity + quantity
        new_quality = ((inventory.quality * inventory.quantity) + (market_price.quality * quantity)) / total_quantity
        inventory.update!(quantity: total_quantity, quality: new_quality.to_i)
      else
        inventory.update!(quantity: quantity, quality: market_price.quality)
      end
      
      ctx[:inventory] = inventory
    end
    true
  rescue => e
    ctx[:errors] = [e.message]
    false
  end

  def update_market(ctx, market_price:, quantity:, **)
    market_price.update!(stock: market_price.stock - quantity)
  end
end