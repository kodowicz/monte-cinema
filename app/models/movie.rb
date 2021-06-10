class Movie < ApplicationRecord
  has_many :screenings
  has_many :tickets
end
