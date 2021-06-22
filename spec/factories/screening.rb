FactoryBot.define do
  factory :screening do
    starts_at { Time.current + 3.hours }
    ends_at { Time.current + 3.hours + create(:movie).duration.minutes }
    cinema_hall { create(:cinema_hall) }
    display_type { create(:display_type) }
    voice_type { create(:voice_type) }
    movie { create(:movie) }
  end
end
