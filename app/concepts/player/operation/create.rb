class Player::Operation::Create < Trailblazer::Operation
  step :build_contract
  step :validate_contract
  step :persist_model_if_valid
  step Subprocess(Player::Operation::InitializePlayerState)
  step :persist_model_after_init

  def build_contract(ctx, params:, **)
    ctx[:model] = Player.new(user_id: params[:player][:user_id])
    ctx[:contract] = Player::Contract::Create.new(ctx[:model])
    ctx[:params] = params
  end

  def validate_contract(ctx, contract:, **)
    ctx[:contract].validate(ctx[:params][:player])
    contract.valid?
  end

  def persist_model_if_valid(_ctx, contract:, **)
    contract.save
  end

  def persist_model_after_init(_ctx, model:, **)
    model.save!
  end
end
