class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)

    unless User.find_by(email: user.email)
      user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup', notice: "Error: couldn't complete signup process, please try again"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
