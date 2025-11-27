class PlayersController < ApplicationController
  def index
    result = Player::Operation::Index.call(params: { user_id: params[:user_id] })

    puts "Result: #{result.inspect}"
    puts "Success?: #{result.success?}"
    puts "Players: #{result[:players].inspect}"
    puts "User ID: #{result[:user_id].inspect}"

    render cell(Player::Cell::Index, result)
  end

  def new
    result = Player::Operation::New.call(params: { user_id: params[:user_id] })
    render cell(Player::Cell::New, result)
  end

  def create
    run Player::Operation::Create do |result|
      return redirect_to player_path(result[:contract].model), notice: "Player created successfully"
    end
    
    render cell(Player::Cell::New, @model, user_id: params[:player][:user_id])
  end

  def show
    result = Player::Operation::Show.call(params: { id: params[:id] })
    render cell(Player::Cell::Show, result)
  end

  def buy_good
    redirect_to player_path(params[:id]), notice: "Buy functionality coming soon"
  end

  def sell_good
    redirect_to player_path(params[:id]), notice: "Sell functionality coming soon"
  end

  def travel
    # TODO: Vytvoříme Travel operation
    redirect_to player_path(params[:id]), notice: "Travel functionality coming soon"
  end

  private

  def player_params
    { player: params.require(:player).permit(:name, :user_id) }
  end
end