class AddTimeAndDateToReservation < ActiveRecord::Migration
  def change
    add_column  :reservations, :time, :time
    add_column  :reservations, :date, :date
  end
end
