class RemoveDatetimeFromReservation < ActiveRecord::Migration
  def change
    remove_column :reservations, :datetime
  end
end
