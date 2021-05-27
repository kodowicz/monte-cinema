class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
end
