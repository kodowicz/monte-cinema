class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :tickets, dependent: :destroy
end
