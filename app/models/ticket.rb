class Ticket < ApplicationRecord
  belongs_to :reservation, dependent: :destroy

  self.inheritance_column = :_type_disabled
end
