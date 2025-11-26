class Player::Operation::New < Trailblazer::Operation
  step :build_contract

  def build_contract(ctx, params:, **)
    user_id = params[:user_id]
    player = Player.new(user_id: user_id)
    ctx[:contract] = Player::Contract::Create.new(player)
    ctx[:user_id] = user_id
  end
end