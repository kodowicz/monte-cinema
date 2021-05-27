class AddTicketsToMovie < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :movie, null: false, foreign_key: true
  end
end
