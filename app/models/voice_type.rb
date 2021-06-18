# frozen_string_literal: true

class VoiceType < ApplicationRecord
  has_many :screenings
end
