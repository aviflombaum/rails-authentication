class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params.dig(:user, :email))
    if @user && @user.authenticate(params.dig(:user, :password))
      sign_in(@user)
      redirect_to root_path, notice: "You have successfully logged in!"
    else
      flash.now[:alert] = "There was a problem logging in."
      render :new, status: 422
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You have been logged out."
  end
end
