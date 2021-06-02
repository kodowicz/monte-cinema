class CinemaHallSeats < ActiveRecord::Migration[6.1]
  def change
    add_column :cinema_halls, :seats, :text, array: true, default: []
    add_column :cinema_halls, :not_available, :text, array: true, default: []
  end
end
