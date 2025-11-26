class User::Cell::New < Trailblazer::Cell
  def show
    render
  end

  def contract
    model[:contract]
  end
end