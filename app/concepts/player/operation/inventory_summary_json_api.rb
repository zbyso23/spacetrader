class Player::Operation::InventorySummaryJsonApi < Trailblazer::Operation
  step :fetch_player
  step :prepare_inventory_relation

  def fetch_player(ctx, params:, **)
    ctx[:model] = Player.find_by(id: params[:id])
    ctx[:model].present?
  end

  def prepare_inventory_relation(ctx, model:, **)
    ctx[:inventory_records] = model.player_inventories
    true
  end
  # def prepare_jsonapi_response(ctx, params:, model:, **)
  #   inventory_records = model.player_inventories.includes(:good)

  #   ctx[:jsonapi_data] = inventory_records.map do |inv|
  #     {
  #       type: 'inventory',
  #       id: inv.id.to_s,
  #       attributes: {
  #         quantity: inv.quantity,
  #         quality: inv.quality
  #       },
  #       relationships: {
  #         good: { data: { type: 'good', id: inv.good.id.to_s } }
  #       }
  #     }
  #   end

  #   ctx[:jsonapi_included] = if params[:include]&.split(',')&.include?('good')
  #                              inventory_records.map do |inv|
  #                                {
  #                                  type: 'good',
  #                                  id: inv.good.id.to_s,
  #                                  attributes: {
  #                                    name: inv.good.name,
  #                                    description: inv.good.description
  #                                  }
  #                                }
  #                              end.uniq { |i| i[:id] }
  #                            else
  #                              []
  #                            end

  #   true
  # end
end
