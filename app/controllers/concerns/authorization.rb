module Authorization
  extend ActiveSupport::Concern

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorized
    current_permission.access_grant?(params[:controller], params[:action])
  end

end