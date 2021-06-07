class AddTicketsToCinemaHall < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :cinema_hall, null: false, foreign_key: true
  end
end
