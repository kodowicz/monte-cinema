FactoryBot.define do
  factory :reservation do
    status { 'paid' }
    expires_at { Time.current + 1.hour }
    user { create(:user) }
    screening { create(:screening) }
    ticket_desk { create(:ticket_desk) }
  end

  factory :paid_reservation, parent: :reservation do
    status { 'paid' }
  end

  factory :unpaid_reservation, parent: :reservation do
    status { 'created' }
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
