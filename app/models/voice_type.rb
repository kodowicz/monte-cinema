# frozen_string_literal: true

class VoiceType < ApplicationRecord
  VOICE_TYPES = %w[original dubbing subtitles].freeze
  has_many :screenings

  validates_inclusion_of :name, in: VOICE_TYPES
end
