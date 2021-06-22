FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    sequence(:phone_number) { Faker::PhoneNumber.cell_phone }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(10..50) }
    real_user { true }
    role { 'client' }
  end

  factory :admin, parent: :user do
    role { 'admin' }
  end

  factory :emplyee, parent: :user do
    role { 'employee' }
  end

  factory :fake_user, parent: :user do
    real_user { false }
  end
end
