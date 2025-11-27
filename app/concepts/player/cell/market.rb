class Player::Cell::Market < Trailblazer::Cell
  def show
    render
  end

  def player
    model[:player]
  end

  def planet
    model[:planet]
  end

  def market_prices
    model[:market_prices]
  end

  def inventory
    model[:inventory]
  end

  private

  def planet_badge
    if planet.has_fixed_quality?
      '<span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">✓ Bank</span>'.html_safe
    else
      '<span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-yellow-100 text-yellow-800">⚠ Loan Sharks</span>'.html_safe
    end
  end
end