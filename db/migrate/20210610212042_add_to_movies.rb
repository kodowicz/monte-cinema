class AddToMovies < ActiveRecord::Migration[6.1]
  def up
    add_column :movies, :description, :string, default: ""
    add_column :movies, :poster, :text, default: ""
    add_column :movies, :trailer, :text, default: ""
    add_column :movies, :direction, :text, default: ""
    add_column :movies, :production, :text, default: ""
    add_column :movies, :ratio, :integer, default: 0
    add_column :movies, :release_at, :datetime
  end

  def down
    remove_column :movies, :description, :string, default: ""
    remove_column :movies, :poster, :text, default: ""
    remove_column :movies, :trailer, :text, default: ""
    remove_column :movies, :direction, :text, default: ""
    remove_column :movies, :production, :text, default: ""
    remove_column :movies, :ratio, :integer, default: 0
    remove_column :movies, :release_at, :datetime
  end
end
