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
    reserved_seats = self.reservations.inject(0) { |sum, r| sum += r.number_of_people }
    return self.number_of_seats - reserved_seats
  end

  def operation_hours
    "Open from #{open_at} till #{close_at}"
  end

  # def open_at
  #   super().strftime("%I:%M %p")
  # end

  # def close_at
  #   super().strftime("%I:%M %p")
  # end


end
