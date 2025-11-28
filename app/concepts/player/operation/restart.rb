class Player::Operation::Restart < Trailblazer::Operation
  step Model(Player, :find_by)
  step :set_player
  step Player::Macro::Reset.call
  step Player::Macro::ClearInventory.call
  step Player::Macro::AddStartItems.call

  def set_player(ctx, model:, **)
    ctx[:errors] = []
    ctx[:player] = model
    true
  end
end