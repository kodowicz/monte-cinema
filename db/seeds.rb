# frozen_string_literal: true

Movie.destroy_all
CinemaHall.destroy_all
Screening.destroy_all
User.destroy_all
TicketDesk.destroy_all
Reservation.destroy_all
Ticket.destroy_all

genre = %w[action horror romance drama comedy science-fiction thriller musical documentary western war historical]
display_type = %w[2D 3D IMAX SCREENX]
voice_type = %w[original dubbing subtitles]

def english_description
  (1..rand(5..10)).map do
    "#{Faker::Book.title}. "
  end.join
end

genres = genre.map.with_index do |name, id|
  Genre.create(
    id: id + 1,
    name: name
  )
end

display_types = display_type.map.with_index do |type, id|
  DisplayType.create(
    id: id + 1,
    name: type
  )
end

voice_types = voice_type.map.with_index do |type, id|
  VoiceType.create(
    id: id + 1,
    name: type
  )
end

cinema_halls = [
  CinemaHall.create(
    id: 1,
    name: 'cinema hall 1',
    capacity: 100,
    not_available: %w[A6 A7 B6 B7],
    seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A H], columns: [1, 13] }).call
  ),
  CinemaHall.create(
    id: 2,
    name: 'cinema hall 2',
    capacity: 50,
    not_available: %w[A1 A4 A5 A6 B4 B5 B6 C4 C5 C6],
    seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A F], columns: [1, 10] }).call
  ),
  CinemaHall.create(
    id: 3,
    name: 'cinema hall 3',
    capacity: 100,
    not_available: %w[A6 A7 B6 B7],
    seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A H], columns: [1, 13] }).call
  ),
  CinemaHall.create(
    id: 4,
    name: 'cinema hall 4',
    capacity: 25,
    not_available: %w[A3 A4 A5 B3 B4 B5 C3 C4 C5 E7],
    seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A E], columns: [1, 7] }).call
  ),
  CinemaHall.create(
    id: 5,
    name: 'cinema hall 5',
    capacity: 50,
    not_available: [],
    seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A E], columns: [1, 10] }).call
  )
]

User.create(
  email: 'cinema@monterail.com', 
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  phone_number: Faker::PhoneNumber.cell_phone,
  age: 18, 
  real_user: false, 
  role: 'employee'
)
User.create(
  email: 'admin@monterail.com',
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name,
  phone_number: Faker::PhoneNumber.cell_phone,
  age: 18,
  real_user: true,
  role: 'admin'
)
employees = (1..5).map do
  User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    age: 18,
    real_user: true,
    role: 'employee'
  )
end
users = (1..10).map do
  User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    age: rand(10..50),
    real_user: true,
    role: 'client'
  )
end

TicketDesk.create(id: 1, online: true)
ticket_desks = (2..4).map do |id|
  TicketDesk.create(
    id: id,
    online: false
  )
end

movies = (1..20).map do |id|
  Movie.create(
    id: id,
    title: Faker::Book.title,
    direction: Faker::Name.name,
    production: "#{Faker::Address.country}, 2021",
    description: english_description,
    poster: Faker::Avatar.image,
    trailer: Faker::Avatar.image,
    release_at: rand(Time.current - 7.days..Time.current + 7.days),
    age_restriction: rand(0..18),
    duration: rand(120..200),
    ratio: rand(1..10),
    genre_id: genres.sample.id
  )
end

screenings = (1..40).map do |id|
  movie = movies.sample
  starts_at = rand(Time.current + 3.hours..Time.current + 4.days)

  Screening.create(
    id: id,
    starts_at: starts_at,
    ends_at: starts_at + movie.duration.minutes,
    movie_id: movie.id,
    cinema_hall_id: cinema_halls.sample.id,
    display_type_id: display_types.sample.id,
    voice_type_id: voice_types.sample.id
  )
end

Reservations::UseCases::CreateOffline.new(
  params: {
    ticket_desk_id: ticket_desks.sample[:id],
    screening_id: screenings[0].id,
    tickets: [
      { price: 25,  ticket_type: 'normal', seat: 'A1' },
      { price: 25,  ticket_type: 'normal', seat: 'A2' },
      { price: 25,  ticket_type: 'normal', seat: 'A3' },
      { price: 15,  ticket_type: 'child', seat: 'B1' },
      { price: 15,  ticket_type: 'child', seat: 'B2' }
    ]
  }
).call

Reservations::UseCases::CreateOffline.new(
  params: {
    ticket_desk_id: ticket_desks.sample[:id],
    screening_id: screenings[0].id,
    tickets: [
      { price: 25,  ticket_type: 'normal', seat: 'D1' },
      { price: 25,  ticket_type: 'normal', seat: 'D2' },
      { price: 25,  ticket_type: 'normal', seat: 'D3' },
      { price: 15,  ticket_type: 'child', seat: 'D4' }
    ]
  }
).call

Reservations::UseCases::CreateOffline.new(
  params: {
    ticket_desk_id: ticket_desks.sample[:id],
    screening_id: screenings[1].id,
    tickets: [
      { price: 15,  ticket_type: 'student', seat: 'D1' },
    ]
  }
).call

Reservations::UseCases::CreateOnline.new(
  user: users.sample,
  params: {
    screening_id: screenings[0].id,
    tickets: [
      { price: 20,  ticket_type: 'student', seat: 'E1' },
      { price: 20,  ticket_type: 'student', seat: 'E2' },
      { price: 20,  ticket_type: 'student', seat: 'E3' }
    ]
  }
).call.paid!

Reservations::UseCases::CreateOnline.new(
  user: users.sample,
  params: {
    screening_id: screenings[1].id,
    tickets: [
      { price: 25,  ticket_type: 'normal', seat: 'B1' },
      { price: 25,  ticket_type: 'normal', seat: 'B2' },
      { price: 25,  ticket_type: 'normal', seat: 'B3' },
      { price: 15,  ticket_type: 'child', seat: 'B9' },
      { price: 15,  ticket_type: 'child', seat: 'B10' }
    ]
  }
).call.paid!
