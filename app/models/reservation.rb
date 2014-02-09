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

  def time
    super() #.strftime("%I:%M %p")
  end

  def within_open_hours?
    if !time.to_time.between?(location.open_at.to_time, location.close_at.to_time)
      errors.add(:time, "can not be outside of hours of operation")
    end
  end

end