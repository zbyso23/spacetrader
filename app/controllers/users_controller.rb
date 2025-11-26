class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @form = User::Contract::Create.new(User.new)
  end

  def create
    result = User::Operation::Create.call(params: user_params)

    if result.success?
      redirect_to root_path, notice: "User created!"
    else
      @form = result[:contract]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
