class Reservation < ActiveRecord::Base

  belongs_to :member
  belongs_to :location

  has_one :restaurant, through: :location

  # default_scope { order(time: :desc, created_at: :desc)}
  # scope :upcoming, -> { where("date >", Date.today)  }
  # scope :past, -> { where("date < :today ? OR (date == :today AND time <= :time)", { today: Date.today, time: Time.now.strftime("%I:%M %p").to_time)  }) }
  validates :number_of_people, numericality: { only_integer: true }

  validate :datetime_validations

  validate :valid_number_of_people
  validate :valid_time
  validate :valid_date
  validate :valid_date_time
  validate :full?









  # Generate an array of operation hours for the location
  def available_hour
    available_hours = []
    location.operation_hours.times do |i|
      available_hours << (location.open_at + i.hour).strftime("%I:%M %p")
    end
    return available_hours
  end

  # returns the number of available seats at the given date and time
  def available_seats
    reserved_seats = find_reserved_seats(date, time)
    return location.number_of_seats - reserved_seats
  end

  def reserved_time
    datetime.strftime("%I%p")
  end

  def time_past?
    date.past? || (date.today? && time.strftime("%I:%M %p").to_time.past?)
  end

private

  # Check whether or not the location is full on the given date and time
  def full?
    reserved_seats = find_reserved_seats(date, time)
    if (location.number_of_seats - reserved_seats <= 0)
      errors[:base] << "The restaurant is full on #{date} at #{time.strftime("%I:%M %p")}"
    end
  end

  # Find how many seats have been reserved on the given date and time
  def find_reserved_seats(d, t)
    return (location.reservations.where(date: d, time: t).select do |r|
      r.persisted? && r.id != id
    end).inject(0) do |sum, r|
      sum + r.number_of_people
    end
  end

  def valid_number_of_people
    if number_of_people.blank?
      errors[:base] << "You got to tell me how many people are coming!"
    elsif number_of_people < 1
      errors[:base] << "Can't have negative number. Try a float !!!"
    elsif number_of_people > available_seats
      errors[:base] << "Too many people are attending, too little seats!"
    end
  end

  def datetime_validations
    if datetime.blank?
      errors[:base] << "So when are you coming?"
    elsif !within_open_hours?
    end
  end

  def valid_time
    if time.blank?
      errors[:base] << "So when are you coming?"
    elsif !within_open_hours?
      errors[:base] << "#{location.restaurant.name} is not open at #{time.strftime("%I%p")}"
    end
  end

  def valid_date
    if date.blank?
      errors[:base] << "So when are you coming"
    elsif date > Time.now.beginning_of_day + 1.year
      errors[:base] << "You are looking to far ahead! Can't book it now!"
    end
  end

  def valid_date_time
    if time_past?
      errors[:base] << "We are waiting for you to invent time machine! let us know"
    end
  end

  def within_open_hours?

    closing_time = (location.close_at <= location.open_at ? location.close_at + 24.hour : location.close_at)
    time.between?(location.open_at, closing_time - 1.hour)
  end

end