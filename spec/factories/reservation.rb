# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    status { "paid" }
    expires_at { Time.current + 1.hour }
    user
    screening
    association :ticket_desk, factory: :ticket_desk_offline
  end

  factory :paid_reservation, parent: :reservation do
    status { "paid" }
  end

  factory :unpaid_reservation, parent: :reservation do
    status { "created" }
    association :ticket_desk, factory: :ticket_desk_online
  end

  trait :with_tickets do
    after :create do |reservation, _|
      create(:ticket, reservation: reservation)
      create(:ticket, reservation: reservation)
      create(:ticket, reservation: reservation)
      create(:ticket, reservation: reservation)
      create(:ticket, reservation: reservation)
    end
  end
end
