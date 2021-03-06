class Location < ActiveRecord::Base

  belongs_to :restaurant

  has_many :reservations
  has_many :reserved_members, through: :reservations, source: 'member'

  validates :address, presence: true

  # Geocode for address
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :number_of_seats, numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 1,
                                message: "must be a valid number ( Greater or equal to 1)"
                              }

  def operation_hours
    ((add_a_day_if_open_through_midnight - open_at.to_time) / 3600).to_i
  end

  def add_a_day_if_open_through_midnight
    open_through_midnight? ? close_at + 1.day : close_at
  end

  def open_through_midnight?
    close_at.to_time <= open_at.to_time
  end

  def open_hours
    "#{open_at.strftime("%I%p")} - #{close_at.strftime("%I%p")}"
  end

end
