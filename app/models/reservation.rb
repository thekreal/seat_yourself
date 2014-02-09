class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :time, presence: true
  validates :number_of_people, numericality: {
                                only_integer: true,
                              }

  validate :check_party_size, on: :create
  validate :within_open_hours?, on: :create


  def check_party_size
    if self.location.available_seats < self.number_of_people
      errors.add(:number_of_people, "exceeds available seats")
    end
  end

  def within_open_hours?
    if !self.time.strftime("%I:%M %p").between?(self.location.open_time, self.location.close_time)
      errors.add(:time, "can not be outside of hours of operation")
    end
  end

end