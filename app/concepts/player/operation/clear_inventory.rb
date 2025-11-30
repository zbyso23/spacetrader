class Player::Operation::ClearInventory < Trailblazer::Operation
  step :destroy_inventory

  def destroy_inventory(_ctx, model:, **)
    model.player_inventories.destroy_all
    true
  end
end
