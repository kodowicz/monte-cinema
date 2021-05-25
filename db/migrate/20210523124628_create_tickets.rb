class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :movie_title
      t.string :seat
      t.string :type
      t.float :price
      t.timestamps
    end
  end
end
