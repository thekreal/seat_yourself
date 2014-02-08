class Location < ActiveRecord::Base
  belongs_to :restaurant
  has_many :reservations

  validates :address, presence: true

  validates :number_of_seats, numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 1
                              }

  # validates :restaurant_id, presence: true

private

end
