class ChangeCinemaHall < ActiveRecord::Migration[6.1]
  def change
    rename_column :cinema_halls, :hall_name, :name
    rename_column :cinema_halls, :hall_size, :capacity
  end
end
