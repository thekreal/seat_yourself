class ChangeTimeToDatetimeFromReservation < ActiveRecord::Migration
  def change
    rename_column :reservations, :time, :datetime
  end
end
