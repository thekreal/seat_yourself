class AddRestaurantIdToRestaurant < ActiveRecord::Migration
  def change
    add_reference :restaurants, :restaurant_owner, index: true
  end
end
