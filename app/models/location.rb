class Location < ActiveRecord::Base
  belongs_to :restaurant
  has_many :reservations
  has_many :users, through: :reservations

  validates :address, presence: true

  validates :number_of_seats, numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 1
                              }

  validates :restaurant_id, presence: true

  def available_seats
    reserved_seats = self.reservations.inject(0) { |sum, r| sum += r.number_of_people }
    return self.number_of_seats - reserved_seats
  end

  [:open, :close].each do |attr|
    define_method("#{attr}_time") { return send("#{attr}_at").strftime("%I:%M %p") }
  end

end
