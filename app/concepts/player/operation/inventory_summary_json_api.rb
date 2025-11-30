class Player::Operation::InventorySummaryJsonApi < Trailblazer::Operation
  step :fetch_player
  step :prepare_inventory_relation
  step Policy::Guard(Player::Policy::InventorySummaryPolicy.new)

  def fetch_player(ctx, params:, **)
    ctx[:model] = Player.find_by(id: params[:id])
    ctx[:model].present?
  end

  def prepare_inventory_relation(ctx, model:, **)
    ctx[:inventory_records] = model.player_inventories
    true
  end
end
