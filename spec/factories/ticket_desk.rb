# frozen_string_literal: true

FactoryBot.define do
  factory :ticket_desk do
    factory :ticket_desk_online do
      online { true }
    end

    factory :ticket_desk_offline do
      online { false }
    end
  end
end
