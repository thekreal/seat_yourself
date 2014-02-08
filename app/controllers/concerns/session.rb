module Session
  extend ActiveSupport::Concern

private

  def current_user
    @current_user ||= User.find_by(token: User.encrypt(cookies[:token]))
  end

  def current_user=(user)
    @current_user = user
  end

  def signin(user)
    token = User.new_token
    cookies[:token] = { value: token, expires: 2.hour.from_now }
    user.update_attribute(:token, User.encrypt(token))
    self.current_user = user
  end

  def signout
    cookies[:token] = nil
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def signin_action
    unless signed_in?
      flash[:warning] = "Please sign in first"
      redirect_to :signin
    end
  end

  def current_user?(user)
    current_user == user
  end

  def self_action
    unless current_user?(@user)
      flash[:warning] = "You are not authorized to view other people's profile"
      redirect_to current_user
    end
  end

end