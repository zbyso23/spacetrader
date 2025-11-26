class Player::Cell::New < Trailblazer::Cell
  def show
    render
  end

  def contract
    model[:contract]
  end