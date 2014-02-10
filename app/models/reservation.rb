class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  has_one :restaurant, through: :location

  default_scope { order(time: :desc, created_at: :desc)}

  validates :number_of_people, numericality: { only_integer: true }

  validate :valid_number_of_people
  validate :valid_time
  validate :valid_date
  validate :valid_date_time

  @duration = 1.hour

  def available_hour
    available_hours = []
    ((location.close_at.to_time - location.open_at.to_time) / 3600).to_int.times do |i|
      time = (location.open_at + i.hour)
      date = Time.now.beginning_of_day if date.nil?
      available_hours << time.strftime("%I:%M %p") unless full?(date, time)
    end
    return available_hours
  end

  def full?(d, t)
    reserved_seats = find_reserved_seats(d, t)
    return location.number_of_seats - reserved_seats <= 0 ? true : false
  end

  def available_seats
    reserved_seats = find_reserved_seats(date, time)
    return location.number_of_seats - reserved_seats
  end

  def find_reserved_seats(d, t)
    return (location.reservations.where(date: d, time: t).select do |r|
      r.persisted? && r.id != id
    end).inject(0) do |sum, r|
      sum + r.number_of_people
    end
  end


  def reserved_time
    time.strftime("%I%p")
  end

private

  def valid_number_of_people
    if number_of_people.blank?
      errors[:base] << "You got to tell me how many people are coming!"
    elsif number_of_people < 1
      errors[:base] << "Can't have negative number. Try a float !!!"
    elsif number_of_people > available_seats
      errors[:base] << "Too many people are attending, too little seats!"
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
    if date.today? && time.strftime("%I:%M %p").to_time.past?
      errors[:base] << "We are waiting for you to invent time machine! let us know"
    end
  end

  def within_open_hours?
    # Time column has the same dummy date 2000-01-01
    # therefore, if the closing time is smaller than the open time,
    # example: Open at 10AM and Close at 12AM ,
    # then the closing time should add 1 day in order to make
    # the validation condition valid, test code below
    # => ("2000-01-01 23:00:00 UTC".to_time - location.open_at) / 3600
    # => ("2000-01-01 00:00:00 UTC".to_time - location.open_at) / 3600
    # => ("2000-01-01 02:00:00 UTC".to_time - location.open_at) / 3600
    closing_time = (location.close_at <= location.open_at ? location.close_at + 24.hour : location.close_at)
    time.between?(location.open_at, closing_time - 1.hour)
  end

end