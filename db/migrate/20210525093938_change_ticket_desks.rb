class ChangeTicketDesks < ActiveRecord::Migration[6.1]
  def change
    remove_column :ticket_desks, :type, :string
    remove_column :ticket_desks, :name, :string
    add_column :ticket_desks, :online, :boolean
  end
end
