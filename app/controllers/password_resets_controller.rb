class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordResetToken.new
  end

  def create
    @password_reset = PasswordResetToken.new(password_reset_params)
    @password_reset.save
    UserMailer.password_reset_token(@password_reset.user).deliver_later

    flash[:notice] = "A link to reset your password has been sent to your email."
    redirect_to root_url
  end

  def edit
    @password_reset = PasswordResetToken.find_by_valid_token(params[:id])
    if @password_reset && @password_reset.user
      @user = @password_reset.user
    else
      flash[:alert] = "Your password reset link is not valid."
      redirect_to new_password_reset_path
    end
  end

  def update
    @password_reset = PasswordResetToken.find_by_valid_token(params[:id])
    if @password_reset && @password_reset.user
      if @password_reset.user.update(user_params)
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
    params.require(:password_reset_token).permit(:email)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
