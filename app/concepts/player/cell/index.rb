class Player::Cell::Index < Trailblazer::Cell
  def show
    render
  end

  def players
    model[:players]
  end

  def user_id
    model[:user_id]
  end
end