class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      @errors = @user.errors.full_messages
      render json: @error
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password) 
    end
end