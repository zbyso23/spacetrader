class Player::Operation::Create < Trailblazer::Operation
  step :build_contract
  step :validate_contract
  step :set_starting_planet
  step :persist

  def build_contract(ctx, params:, **)
    user_id = params[:player][:user_id]
    player = Player.new(user_id: user_id)
    ctx[:contract] = Player::Contract::Create.new(player)
    ctx[:contract].validate(params[:player])
  end

  def validate_contract(ctx, contract:, **)
    contract.valid?
  end

  def set_starting_planet(ctx, contract:, **)
    contract.model.current_planet = Planet.find_by(name: 'Mars')
    contract.model.fuel = 100
    contract.model.credit = 1000
    contract.model.reputation = 1
  end

  def persist(ctx, contract:, **)
    if contract.save
      player = contract.model
      water = Good.find_by(name: 'Water')
      protein = Good.find_by(name: 'Protein')
      
      PlayerInventory.create(player: player, good: water, quantity: 10, quality: 50)
      PlayerInventory.create(player: player, good: protein, quantity: 5, quality: 50)
      
      true
    else
      false
    end
  end
end