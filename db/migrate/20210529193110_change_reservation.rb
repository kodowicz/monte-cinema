class ChangeReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :expires_at, :datetime, null: false
    add_column :reservations, :status, :integer, null: false, default: 0
    remove_column :reservations, :paid, :boolean
  end
end
