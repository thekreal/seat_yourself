module Authorization
  extend ActiveSupport::Concern

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    current_model_name = params[:controller].singularize.capitalize
    params[:id] ? ActiveModel.const_get(current_model_name).find(params[:id]) : nil
  end

  def authorize?
    current_permission.allow_action?(params[:controller], params[:action], current_resource)
  end

  def authorize
    if !authorize?
      flash[:info] = "You are not authorized"
      redirect_to :signin
    end
  end


end