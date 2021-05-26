class CinemaHall < ApplicationRecord
  has_many :screenings, dependent: :destroy
end
