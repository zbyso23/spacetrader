class Player::Operation::Index < Trailblazer::Operation
  step :fetch_players

  def fetch_players(ctx, params:, **)
    user_id = params[:user_id]
    ctx[:players] =
      user_id ? Player.where(user_id: user_id).includes(:current_planet) : Player.includes(:user, :current_planet).all
    ctx[:user_id] = user_id
  end
end
