class UsersController < ApplicationController
  def index
    result = User::Operation::Index.call

    if result.success?
      render cell(User::Cell::Index, result)
    else
      redirect_to root_path, alert: "Error loading users"
    end
  end

  def new
    result = User::Operation::New.call
    render concept(User::Cell::New, result)
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
