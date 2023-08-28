class ApplicationController < ActionController::Base
  private

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?
end
