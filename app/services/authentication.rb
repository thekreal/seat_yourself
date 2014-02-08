class Authentication

  def initialize(params)
    @params = params
  end

  def user
    @user = User.find_by(email: @params[:email])
  end

  def authenticate
    user && user.authenticate(@params[:password])
  end

end