class RestaurantOwner < User
  has_many  :restaurants, dependent: :destroy
  has_many  :locations, through: :restaurants
end