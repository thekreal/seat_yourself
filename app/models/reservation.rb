class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :time, presence: true
  validates :number_of_people, numericality: {
                                only_integer: true,
                                less_than_or_equal_to: :location_seats
                              }
end