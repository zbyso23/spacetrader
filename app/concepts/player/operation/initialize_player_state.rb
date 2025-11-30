class Player::Operation::InitializePlayerState < Trailblazer::Operation
  step Subprocess(Player::Operation::SetStartingAttributes)
  step Subprocess(Player::Operation::ClearInventory)
  step Subprocess(Player::Operation::AddStartItems)
end
