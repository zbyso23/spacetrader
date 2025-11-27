class Player::Operation::SellGood < Trailblazer::Operation
  step :find_player
  step :find_inventory
  step :find_market_price
  step :validate_sale
  step :process_sale
  step :update_market

  def find_player(ctx, params:, **)
    ctx[:player] = Player.find_by(id: params[:player_id])
    ctx[:player].present?
  end

  def find_inventory(ctx, params:, player:, **)
    ctx[:inventory] = player.player_inventories.find_by(good_id: params[:good_id])
    ctx[:inventory].present?
  end

  def find_market_price(ctx, params:, player:, **)
    ctx[:market_price] = MarketPrice.includes(:good, :planet).find_by(
      planet_id: player.current_planet_id,
      good_id: params[:good_id]
    )
    ctx[:market_price].present?
  end

  def validate_sale(ctx, params:, inventory:, **)
    quantity = params[:quantity].to_i
    
    ctx[:quantity] = quantity
    ctx[:errors] = []
    
    if quantity <= 0
      ctx[:errors] << "Quantity must be positive"
      return false
    end
    
    if quantity > inventory.quantity
      ctx[:errors] << "Not enough goods (have: #{inventory.quantity})"
      return false
    end
    
    true
  end

  def process_sale(ctx, player:, inventory:, market_price:, quantity:, **)
    ActiveRecord::Base.transaction do
      # Vypočítej cenu (kvalita ovlivňuje cenu)
      quality_modifier = inventory.quality / 100.0
      price_per_unit = (market_price.sell_price * quality_modifier).to_i
      total_earning = price_per_unit * quantity
      
      ctx[:total_earning] = total_earning
      ctx[:price_per_unit] = price_per_unit
      
      # Přidej kredity
      player.update!(credit: player.credit + total_earning)
      
      # Odečti z inventáře
      new_quantity = inventory.quantity - quantity
      if new_quantity == 0
        inventory.destroy!
      else
        inventory.update!(quantity: new_quantity)
      end
    end
    true
  rescue => e
    ctx[:errors] = [e.message]
    false
  end

  def update_market(ctx, market_price:, quantity:, **)
    market_price.update!(stock: market_price.stock + quantity)
  end
end