class ApplicationController < ActionController::Base
  def signed_in?
    false
  end
  helper_method :signed_in?
end
