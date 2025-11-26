class PlayersController < ApplicationController
  def index
    run Player::Operation::Index, params: { user_id: params[:user_id] }
    render cell(Player::Cell::Index, @model)
  end

  def new
    run Player::Operation::New, params: { user_id: params[:user_id] }
    render cell(Player::Cell::New, @model)
  end

  def create
    run Player::Operation::Create do |result|
      return redirect_to player_path(result[:contract].model), notice: "Player created successfully"
    end
    
    render cell(Player::Cell::New, @model)
  end

  def show
    run Player::Operation::Show, params: { id: params[:id] }
    render cell(Player::Cell::Show, @model)
  end

  def travel
    # TODO: Vytvoříme Travel operation
    redirect_to player_path(params[:id]), notice: "Travel functionality coming soon"
  end
end