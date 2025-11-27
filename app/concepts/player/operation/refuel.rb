class Player::Operation::Refuel < Trailblazer::Operation
  step :find_player
  step :validate_refuel
  step :process_refuel

  def find_player(ctx, params:, **)
    ctx[:player] = Player.find_by(id: params[:player_id])
    ctx[:player].present?
  end

  def validate_refuel(ctx, player:, **)
    total_cost = 100
    ctx[:errors] = []
    if player.credit < total_cost
      ctx[:errors] << "Not enough credits (need: #{total_cost}, have: #{player.credit})"
      return false
    end
    
    ctx[:total_cost] = total_cost
    true
  end

  def process_refuel(ctx, player:, total_cost:, **)
    ActiveRecord::Base.transaction do
      player.update!(credit: player.credit - total_cost, fuel: player.fuel + total_cost)
    end
    true
  rescue => e
    ctx[:errors] = [e.message]
    false
  end
end