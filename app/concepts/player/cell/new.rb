class Player::Cell::New < Trailblazer::Cell
  def show
    render
  end

  def contract
    model[:contract]
  end

  def user_id
    model[:user_id]
  end
end