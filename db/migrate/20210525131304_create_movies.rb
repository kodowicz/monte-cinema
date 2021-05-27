class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :duration
      t.integer :age_restriction, default: 0

      t.timestamps
    end
  end
end
