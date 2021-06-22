# frozen_string_literal: true

class Movie < ApplicationRecord
  MAX_RATIO = 10

  has_many :screenings
  has_many :tickets
  belongs_to :genre
end
