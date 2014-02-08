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

end