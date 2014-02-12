class Permission

  def initialize(user)
    allow :members,             [:new, :create]
    allow :owners,              [:new, :create]
    allow :sessions,            [:new, :create, :destroy]
    allow :restaurants,         [:index, :show]
    if user && user.type == "Member"
      allow :members,           [:show, :edit, :update]
      allow :reservations,      [:new, :create, :edit, :update, :destroy]
    elsif user && user.type == "RestaurantOwner"
      allow :restaurant_owners, [:show, :edit, :update]
      allow :restaurants,       [:new, :create, :edit, :update, :destroy]

    end
  end

  def allow_action?(controller, action, resource = nil)
    allowed = @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

end