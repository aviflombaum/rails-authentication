class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(password_reset_params)

    if @password_reset.save
      flash[:notice] = "A link to reset your password has been sent to your email."
      redirect_to root_url
    end
  end

  def edit
  end

  def update
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end
end
