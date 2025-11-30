class Player::Policy::InventorySummaryPolicy
  def call(ctx, params:, **)
    includes = params[:include].to_s.split(',').map(&:strip)
    ctx[:include_goods] = includes.include?('good')
    true
  end
end
