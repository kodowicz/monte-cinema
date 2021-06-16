class CreateGenres < ActiveRecord::Migration[6.1]
  def up
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end

    remove_column :movies, :genre, :string
    add_reference :movies, :genre, index: true, foreign_key: true
  end

  def down
    remove_reference :movies, :genre, index: true, foreign_key: true
    add_column :movies, :genre, :string
    drop_table :genres
  end
end
