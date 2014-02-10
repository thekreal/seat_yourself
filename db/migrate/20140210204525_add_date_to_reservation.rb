class AddDateToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :date, :date
  end
end
