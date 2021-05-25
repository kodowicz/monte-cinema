class TicketDesk < ApplicationRecord
  has_many :reservations, dependent: :destroy
end
