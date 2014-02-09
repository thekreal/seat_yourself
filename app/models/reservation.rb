class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validate :valid_number_of_people, on: :create
  validate :valid_time, on: :create

  def valid_number_of_people
    if number_of_people.blank?
      errors[:base] << "You got to tell me how many people are coming!"
    elsif number_of_people > location.available_seats
      errors[:base] << "Too many people, too little seats! :("
    end
  end

  def valid_time
    if time.blank?
      errors[:base] << "So when are you coming?"
    elsif !within_open_hours?
      errors[:base] << "#{location.restaurant.name} is not open at #{time.strftime("%I%p")}"
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