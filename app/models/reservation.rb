class Reservation < ApplicationRecord
  has_many :tickets, dependent: :destroy
end
