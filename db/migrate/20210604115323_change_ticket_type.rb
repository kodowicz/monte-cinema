class ChangeTicketType < ActiveRecord::Migration[6.1]
  def up
    add_column :tickets, :ticket_type, :integer, null: false, default: 0
    remove_column :tickets, :type, :string
  end

  def down
    remove_column :tickets, :ticket_type, :integer, null: false, default: 0
    add_column :tickets, :type, :string
  end
end
