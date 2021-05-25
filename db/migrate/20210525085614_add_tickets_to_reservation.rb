class AddTicketsToReservation < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :reservation, null: false, foreign_key: true
  end
end
