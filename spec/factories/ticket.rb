# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    price { 20 }
    seat { "A1" }
    ticket_type { "normal" }
    reservation
  end
end
