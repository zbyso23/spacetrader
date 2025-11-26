class Player::Cell::Index < Trailblazer::Cell
  option :user_id

  def show
    render
  end

  def players
    model[:players]
  end
end