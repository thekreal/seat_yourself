class Member < User

  has_many  :reservations
  has_many  :reserved_restaurants, through: :reservations, source: "restaurant"


end