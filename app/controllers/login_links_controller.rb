class LoginLinksController < ApplicationController
  def show
    @login_token = LoginToken.find_by_valid_token(params[:id])
    if @login_token && @login_token.user
      @login_token.expire!
      sign_in(@login_token.user)
      redirect_to root_path, notice: "You have successfully logged in!"
    else
      redirect_to new_login_link_path, alert: "Your login link has expired. Please request a new one."
    end
  end

  def new
    @login_token = LoginToken.new
  end

  def create
    @login_token = LoginToken.new(login_token_params)
    @login_token.save
    UserMailer.login_token(@login_token.user).deliver_later
    redirect_to root_path, notice: "Login link sent!"
  end

  private

  def login_token_params
    params.require(:login_token).permit(:email)
  end
end
