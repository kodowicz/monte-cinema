# frozen_string_literal: true

Movie.destroy_all
CinemaHall.destroy_all
Screening.destroy_all
Client.destroy_all
TicketDesk.destroy_all
Reservation.destroy_all
Ticket.destroy_all

cinema_hall_1 = CinemaHall.create(
  id: 1,
  name: 'cinema hall 1',
  capacity: 100,
  not_available: %w[A6 A7 B6 B7],
  seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A H], columns: [1, 13] }).call
)
cinema_hall_2 = CinemaHall.create(
  id: 2,
  name: 'cinema hall 2',
  capacity: 50,
  not_available: %w[A1 A4 A5 A6 B4 B5 B6 C4 C5 C6],
  seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A F], columns: [1, 10] }).call
)
cinema_hall_3 = CinemaHall.create(
  id: 3,
  name: 'cinema hall 3',
  capacity: 100,
  not_available: %w[A6 A7 B6 B7],
  seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A H], columns: [1, 13] }).call
)
cinema_hall_4 = CinemaHall.create(
  id: 4,
  name: 'cinema hall 4',
  capacity: 25,
  not_available: %w[A3 A4 A5 B3 B4 B5 C3 C4 C5 E7],
  seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A E], columns: [1, 7] }).call
)
cinema_hall_5 = CinemaHall.create(
  id: 5,
  name: 'cinema hall 5',
  capacity: 50,
  not_available: [],
  seats: CinemaHalls::UseCases::GenerateSeats.new(params: { rows: %w[A E], columns: [1, 10] }).call
)

movie_1 = Movie.create(id: 1, title: 'Harry Potter and the Philosopher`s Stone', genre: 'fantasy', age_restriction: 10, duration: 160)
movie_2 = Movie.create(id: 2, title: 'Harry Potter and the Chamber of Secrets', genre: 'fantasy', age_restriction: 10, duration: 130)
movie_3 = Movie.create(id: 3, title: 'Harry Potter and the Prisoner of Azkaban', genre: 'fantasy', age_restriction: 10, duration: 200)
movie_4 = Movie.create(id: 4, title: 'Avengers: Age of Ultron', genre: 'science fiction', age_restriction: 16, duration: 150)
movie_5 = Movie.create(id: 5, title: 'Ironman 3', genre: 'science fiction', age_restriction: 16, duration: 190)

screening_1 = Screening.create(
  id: 1,
  starts_at: Time.current + 4.hours,
  ends_at: Time.current + 6.hours + 40.minutes,
  cinema_hall_id: cinema_hall_1.id,
  movie_id: movie_1.id
)
screening_2 = Screening.create(
  id: 2,
  starts_at: Time.current + 10.hours,
  ends_at: Time.current + 12.hours + 40.minutes,
  cinema_hall_id: cinema_hall_2.id,
  movie_id: movie_1.id
)
screening_3 = Screening.create(
  id: 3,
  starts_at: Time.current + 2.day,
  ends_at: Time.current + 2.day + 62.hours + 40.minutes,
  cinema_hall_id: cinema_hall_2.id,
  movie_id: movie_2.id
)
screening_4 = Screening.create(
  id: 4,
  starts_at: Time.current + 2.hours,
  ends_at: Time.current + 3.hours + 40.minutes,
  cinema_hall_id: cinema_hall_4.id,
  movie_id: movie_5.id
)
screening_5 = Screening.create(
  id: 5,
  starts_at: Time.current + 5.hours,
  ends_at: Time.current + 8.hours + 10.minutes,
  cinema_hall_id: cinema_hall_4.id,
  movie_id: movie_5.id
)

client_1 = Client.create(id: 1, email: 'montecinema@gmail.com', name: 'Monterail', age: 18, real_user: false)
client_2 = Client.create(id: 2, email: 'emily@gmail.com', name: 'Emily', age: 25, real_user: true)
client_3 = Client.create(id: 3, email: 'john@gmail.com', name: 'John', age: 15, real_user: true)
client_4 = Client.create(id: 4, email: 'david@gmail.com', name: 'David', age: 37, real_user: true)

ticket_desk_1 = TicketDesk.create(id: 1, online: true)
ticket_desk_2 = TicketDesk.create(id: 2, online: false)
ticket_desk_3 = TicketDesk.create(id: 3, online: false)

Reservations::UseCases::CreateOffline.new(
  params: {
    ticket_desk_id: ticket_desk_2.id,
    screening_id: screening_1.id,
    tickets: [
      { price: 25,  ticket_type: 'normal', seat: 'A1' },
      { price: 25,  ticket_type: 'normal', seat: 'A2' },
      { price: 25,  ticket_type: 'normal', seat: 'A3' },
      { price: 15,  ticket_type: 'child', seat: 'B1' },
      { price: 15,  ticket_type: 'child', seat: 'B1' }
    ]
  }
).call

Reservations::UseCases::CreateOffline.new(
  params: {
    ticket_desk_id: ticket_desk_3.id,
    screening_id: screening_1.id,
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
    ticket_desk_id: ticket_desk_3.id,
    screening_id: screening_2.id,
    tickets: [
      { price: 15,  ticket_type: 'student', seat: 'D1' },
    ]
  }
).call

Reservations::UseCases::CreateOnline.new(
  params: {
    screening_id: screening_1.id,
    client_id: client_3.id,
    tickets: [
      { price: 20,  ticket_type: 'student', seat: 'E1' },
      { price: 20,  ticket_type: 'student', seat: 'E2' },
      { price: 20,  ticket_type: 'student', seat: 'E3' }
    ]
  }
).call.paid!

Reservations::UseCases::CreateOnline.new(
  params: {
    screening_id: screening_2.id,
    client_id: client_2.id,
    tickets: [
      { price: 25,  ticket_type: 'normal', seat: 'B1' },
      { price: 25,  ticket_type: 'normal', seat: 'B2' },
      { price: 25,  ticket_type: 'normal', seat: 'B3' },
      { price: 15,  ticket_type: 'child', seat: 'B9' },
      { price: 15,  ticket_type: 'child', seat: 'B10' }
    ]
  }
).call.paid!
