# frozen_string_literal: true

class DisplayType < ApplicationRecord
  DISPLAY_TYPE = %w[2D 3D IMAX SCREENX].freeze
  has_many :screenings

  validates_inclusion_of :name, in: DISPLAY_TYPE
end
