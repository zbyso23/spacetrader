class Player::Operation::Restart < Trailblazer::Operation
  step Model(Player, :find_by), fail_fast: true
  step Subprocess(Player::Operation::InitializePlayerState)
  step :persist_model

  def persist_model(_ctx, model:, **)
    model.save!
  end
end
