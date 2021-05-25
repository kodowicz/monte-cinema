class ChangeCinemaHall < ActiveRecord::Migration[6.1]
  def change
    remove_column :cinema_halls, :hall_name
    remove_column :cinema_halls, :hall_size
    add_column :cinema_halls, :capacity, :integer
  end
end
