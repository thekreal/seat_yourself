class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id, index: true
      t.integer :restaurant_id
      t.datetime :time
      t.integer :number_of_people

      t.timestamps
    end
  end
end
