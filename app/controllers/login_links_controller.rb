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
    if @login_token.save
      redirect_to root_path, notice: "Login link sent!"
    else
      flash.now[:alert] = "There was a problem sending the login link."
      render :new, status: 422
    end
  end

  private

  def login_token_params
    params.require(:login_token).permit(:email)
  end
end
