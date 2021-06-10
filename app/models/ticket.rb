# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum ticket_type: { normal: 0, child: 1, student: 2, senior: 3, family: 4 }

  belongs_to :reservation

  validates :seat, presence: true, format: {
    with: /^[A-Z]{1}\d{1,3}$/,
    message: 'The row must be a letter and the column a number',
    multiline: true
  }
  validates :ticket_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.99 }
  validates :reservation_id, presence: true
end
