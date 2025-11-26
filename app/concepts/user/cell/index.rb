class User::Cell::Index < Trailblazer::Cell
  def show
    render
  end

  def users
    model[:users]
  end
end