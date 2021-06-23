# frozen_string_literal: true

class Genre < ApplicationRecord
  GENRE_TYPES = %w[action horror romance drama comedy science-fiction thriller musical documentary western war
                   historical].freeze
  has_many :movies

  validates_inclusion_of :name, in: GENRE_TYPES
end
