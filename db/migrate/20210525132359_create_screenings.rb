class CreateScreenings < ActiveRecord::Migration[6.1]
  def change
    create_table :screenings do |t|
      t.datetime :start_date
      t.references :cinema_hall, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
