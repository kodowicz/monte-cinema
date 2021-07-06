# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Book.title }
    direction { Faker::Name.name }
    production { "#{Faker::Address.country}, 2021" }
    description { english_description }
    poster { Faker::Avatar.image }
    trailer { Faker::Avatar.image }
    release_at { rand(Time.current - 7.days..Time.current + 7.days) }
    age_restriction { rand(0..18) }
    duration { rand(120..200) }
    ratio { rand(1..10) }
    genre { create(:genre) }

    trait :with_screenings do
      after :create do |movie, _|
        create(:screening, movie: movie)
        create(:screening, movie: movie)
        create(:screening, movie: movie)
        create(:screening, movie: movie)
        create(:screening, movie: movie)
      end
    end
  end
end

private

def english_description
  (1..rand(5..10)).map do
    "#{Faker::Book.title}. "
  end.join
end
