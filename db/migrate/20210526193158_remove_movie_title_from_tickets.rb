class RemoveMovieTitleFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :movie_title, :string
  end
end
