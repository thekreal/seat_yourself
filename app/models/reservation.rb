class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :time, presence: true
  validates :number_of_people, numericality: {
                                only_integer: true,
                              }

  validate :check_party_size, on: :create


  def check_party_size
    if self.location.available_seats < self.number_of_people
      errors.add(:number_of_people, "exceeds available seats")
    end
  end

end