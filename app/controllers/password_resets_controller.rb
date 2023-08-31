class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(password_reset_params)

    flash[:notice] = "A link to reset your password has been sent to your email."
    redirect_to root_url
  end

  def edit
    @user = PasswordReset.find_by_valid_token(params[:id])
    if @user
    else
      flash[:alert] = "Your password reset link is not valid."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = PasswordReset.find_by_valid_token(params[:id])
    if @user
      if @user.update(user_params)
        flash[:notice] = "Your password has been updated."
        redirect_to root_url
      else
        flash.now[:alert] = "There was an error updating your password."
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:error] = "Your password reset link is not valid."
      redirect_to new_password_reset_path
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
