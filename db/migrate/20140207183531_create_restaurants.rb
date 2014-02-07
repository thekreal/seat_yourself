class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string    :name, index: true, unique: true
      t.text      :description

      t.timestamps
    end
  end
end
