class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  delegate :access_grant?, to: :permission

  include Authorization, Session
  helper_method :access_grant?, :current_user, :current_user?, :signed_in?


end
