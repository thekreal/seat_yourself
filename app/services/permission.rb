class Permission

  def initialize(user)
    @user = user
  end

  def access_grant?(controller, action)
    if @user.nil?     # Guest Permission



    elsif @user.customer?

    elsif @user.restaurant_owner?

    else

    end
  end

end