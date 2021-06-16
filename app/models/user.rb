# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  enum role: { client: 0, employee: 1, admin: 2 }

  has_many :reservations
end
