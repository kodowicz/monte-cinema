class Reservation < ApplicationRecord
  enum status: { pending: 0, created: 1, paid: 2, canceled: 3 }

  has_many :tickets, dependent: :delete_all
  belongs_to :ticket_desk
  belongs_to :screening
  belongs_to :user

  validates :status, presence: true
  validates :expires_at, presence: true
  validates :ticket_desk_id, presence: true
  validates :screening_id, presence: true
  validates :user_id, presence: true
end
