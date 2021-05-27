class Reservation < ApplicationRecord
  has_many :tickets
  belongs_to :ticket_desk
  belongs_to :screening
  belongs_to :client
end
