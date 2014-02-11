class RemoveTimeFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :time
    remove_column :reservations, :date
  end
end
