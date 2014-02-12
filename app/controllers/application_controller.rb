class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize

  delegate :allow?, to: :permission

  include Authorization, Session
  helper_method :allow?, :current_user, :current_user?, :signed_in?, :current_resource


end
