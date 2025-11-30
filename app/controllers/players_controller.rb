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
      return redirect_to player_path(result[:contract].model), notice: 'Player created successfully'
    end

    render cell(Player::Cell::New, @model, user_id: params[:player][:user_id])
  end

  def show
    result = Player::Operation::Show.call(params: { id: params[:id] })
    render cell(Player::Cell::Show, result)
  end

  def buy_good
    result = Player::Operation::BuyGood.call(params: {
                                               player_id: params[:id],
                                               good_id: params[:good_id],
                                               quantity: params[:quantity]
                                             })

    if result.success?
      redirect_to player_path(params[:id]),
                  notice: "Purchased #{result[:quantity]} units for #{result[:total_cost]} credits"
    else
      redirect_to player_path(params[:id]), alert: result[:errors].join(', ')
    end
  end

  def sell_good
    result = Player::Operation::SellGood.call(params: {
                                                player_id: params[:id],
                                                good_id: params[:good_id],
                                                quantity: params[:quantity]
                                              })

    if result.success?
      redirect_to player_path(params[:id]),
                  notice: "Sold #{result[:quantity]} units for #{result[:total_earning]} credits"
    else
      redirect_to player_path(params[:id]), alert: result[:errors].join(', ')
    end
  end

  def travel
    result = Player::Operation::Travel.call(params: {
                                              player_id: params[:id],
                                              destination_id: params[:destination_id]
                                            })

    if result.success?
      redirect_to player_path(params[:id]), notice: "Traveled to #{result[:destination].name}"
    else
      redirect_to player_path(params[:id]), alert: result[:errors].join(', ')
    end
  end

  def refuel
    result = Player::Operation::Refuel.call(params: {
                                              player_id: params[:id]
                                            })

    if result.success?
      redirect_to player_path(params[:id]), notice: 'Refueled'
    else
      redirect_to player_path(params[:id]), alert: result[:errors].join(', ')
    end
  end

  def restart
    result = Player::Operation::Restart.call(params: {
                                               id: params[:id]
                                             })
    if result.success?
      redirect_to player_path(params[:id]), notice: 'Restarted'
    else
      redirect_to player_path(params[:id]), alert: result[:errors].join(', ')
    end
  end

  def inventory_summary
    result = Player::Operation::InventorySummaryJsonApi.(params: params)
    if result.success?
      render json: Player::Representer::PlayerInventoryRepresenter.for_collection.prepare(result[:inventory_records])
    else
      render json: { errors: ['Player not found'] }, status: :not_found
    end
  end

  private

  def player_params
    { player: params.require(:player).permit(:name, :user_id) }
  end
end
