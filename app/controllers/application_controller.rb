class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Session

  helper_method :current_user, :signed_in?

end
