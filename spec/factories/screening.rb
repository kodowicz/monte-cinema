# frozen_string_literal: true

FactoryBot.define do
  factory :screening do
    starts_at { Time.current + 3.hours }
    ends_at { Time.current + 3.hours + movie.duration.minutes }
    cinema_hall
    display_type
    voice_type
    movie
  end
end
