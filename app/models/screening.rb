class Screening < ApplicationRecord
  belongs_to :cinema_hall
  belongs_to :movie
  belongs_to :display_type
  belongs_to :voice_type
  has_many :reservations
end
