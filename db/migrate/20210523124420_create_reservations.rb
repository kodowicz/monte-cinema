class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
