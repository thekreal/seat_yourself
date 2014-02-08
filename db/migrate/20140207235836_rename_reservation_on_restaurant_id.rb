class RenameReservationOnRestaurantId < ActiveRecord::Migration
  def change
    rename_column :reservations, :restaurant_id, :location_id
  end
end
