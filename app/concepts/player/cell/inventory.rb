class Player::Cell::Inventory < Trailblazer::Cell
  def show
    render
  end

  def inventory
    model[:inventory]
  end

  def quality_class(quality)
    if quality >= 70
      'bg-green-100 text-green-800'
    elsif quality >= 40
      'bg-yellow-100 text-yellow-800'
    else
      'bg-red-100 text-red-800'
    end
  end
end