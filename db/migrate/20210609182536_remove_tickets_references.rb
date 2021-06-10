class RemoveTicketsReferences < ActiveRecord::Migration[6.1]
  def up
    remove_reference :tickets, :cinema_hall, index: true, foreign_key: true
    remove_reference :tickets, :movie, index: true, foreign_key: true
  end

  def down
    add_reference :tickets, :cinema_hall, index: true, foreign_key: true
    add_reference :tickets, :movie, index: true, foreign_key: true
  end
end
