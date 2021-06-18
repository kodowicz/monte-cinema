# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings
  has_many :tickets
  belongs_to :genre
end
