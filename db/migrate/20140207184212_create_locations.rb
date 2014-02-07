class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string      :address, index: true, unique: true
      t.integer     :number_of_seats
      t.time        :open_at
      t.time        :close_at
      t.references  :restaurant, index: true

      t.timestamps
    end
  end
end
