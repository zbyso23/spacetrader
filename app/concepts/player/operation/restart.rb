class Player::Operation::Restart < Trailblazer::Operation
  step :find_player
  step :reset_player
  step :reset_inventory
  step :add_starting_inventory

  def find_player(ctx, params:, **)
    ctx[:player] = Player.find_by(id: params[:player_id])
    ctx[:player].present?
  end

  def reset_player(ctx, player:, **)
    starting_planet = Planet.find_by(name: 'Mars')
    
    player.update!(
      current_planet: starting_planet,
      fuel: 100,
      credit: 1000,
      reputation: 1
    )
    true
  end

  def reset_inventory(ctx, player:, **)
    player.player_inventories.destroy_all
    true
  end

  def add_starting_inventory(ctx, player:, **)
    water = Good.find_by(name: 'Water')
    protein = Good.find_by(name: 'Protein')
    
    PlayerInventory.create!(player: player, good: water, quantity: 10, quality: 50)
    PlayerInventory.create!(player: player, good: protein, quantity: 5, quality: 50)
    
    true
  rescue => e
    ctx[:errors] = [e.message]
    false
  end
end