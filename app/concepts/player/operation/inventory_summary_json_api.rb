class Player::Operation::InventorySummaryJsonApi < Trailblazer::Operation
  step :fetch_player
  step :prepare_inventory_relation

  def fetch_player(ctx, params:, **)
    ctx[:model] = Player.find_by(id: params[:id])
    ctx[:model].present?
  end

  def prepare_inventory_relation(ctx, model:, params:, **)
    ctx[:inventory_records] = model.player_inventories
    ctx[:include_goods] = params[:include]&.split(',')&.include?('good')
    true
  end
end
