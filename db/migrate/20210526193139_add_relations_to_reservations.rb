class AddRelationsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :client, null: false, foreign_key: true
    add_reference :reservations, :screening, null: false, foreign_key: true
  end
end
