class Location < ActiveRecord::Base
  belongs_to :restaurant
  has_many :reservations
  has_many :reserved_users, through: :reservations, source: 'user'

  validates :address, presence: true

  validates :number_of_seats, numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 1
                              }

  def available_seats
    reserved_seats = reservations.select { |r| !r.id.nil? }.inject(0) { |sum, r| sum + r.number_of_people }
    return number_of_seats - reserved_seats
  end

  def operation_hours
    "#{open_at.strftime("%I%p")} - #{close_at.strftime("%I%p")}"
  end



end
