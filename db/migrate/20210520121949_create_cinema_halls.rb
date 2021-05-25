class CreateCinemaHalls < ActiveRecord::Migration[6.1]
  def change
    create_table :cinema_halls do |t|
      t.string :hall_name
      t.integer :hall_size

      t.timestamps
    end
  end
end
