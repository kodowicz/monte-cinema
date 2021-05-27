Movie.destroy_all
CinemaHall.destroy_all
Screening.destroy_all

cinema_hall_1 = CinemaHall.create(id: 1, name: "cinema hall 1", capacity: 200)
cinema_hall_2 = CinemaHall.create(id: 2, name: "cinema hall 2", capacity: 100)
cinema_hall_3 = CinemaHall.create(id: 3, name: "cinema hall 3", capacity: 100)
cinema_hall_4 = CinemaHall.create(id: 4, name: "cinema hall 4", capacity: 200)
cinema_hall_5 = CinemaHall.create(id: 5, name: "cinema hall 5", capacity: 50)

movie_1 = Movie.create(id: 11, title: "Harry Potter and the Philosopher's Stone", genre: "fantasy", age_restriction: 10, duration: 160)
movie_2 = Movie.create(id: 12, title: "Harry Potter and the Chamber of Secrets", genre: "fantasy", age_restriction: 10, duration: 130)
movie_3 = Movie.create(id: 13, title: "Harry Potter and the Prisoner of Azkaban", genre: "fantasy", age_restriction: 10, duration: 200)
movie_4 = Movie.create(id: 14, title: "Avengers: Age of Ultron", genre: "science fiction", age_restriction: 16, duration: 150)
movie_5 = Movie.create(id: 15, title: "Ironman 3", genre: "science fiction", age_restriction: 16, duration: 190)

screening_1 = Screening.create(id: 21, 
  starts_at: DateTime.parse("26/05/2021 17:00"),
  ends_at: DateTime.parse("26/05/2021 19:40"),
  cinema_hall_id: cinema_hall_1.id,
  movie_id: movie_1.id
)
screening_2 = Screening.create(id: 22, 
  starts_at: DateTime.parse("26/05/2021 13:00"),
  ends_at: DateTime.parse("26/05/2021 15:40"),
  cinema_hall_id: cinema_hall_2.id, 
  movie_id: movie_1.id
)
screening_3 = Screening.create(id: 23,
  starts_at: DateTime.parse("26/05/2021 19:30"),
  ends_at: DateTime.parse("26/05/2021 22:10"),
  cinema_hall_id: cinema_hall_2.id,
  movie_id: movie_1.id
)
screening_4 = Screening.create(id: 24,
  starts_at: DateTime.parse("27/05/2021 11:00"),
  ends_at: DateTime.parse("26/05/2021 14:10"),
  cinema_hall_id: cinema_hall_4.id,
  movie_id: movie_5.id
)
screening_5 = Screening.create(id: 25, 
  starts_at: DateTime.parse("27/05/2021 17:40"),
  ends_at: DateTime.parse("26/05/2021 20:50"),
  cinema_hall_id: cinema_hall_4.id,
  movie_id: movie_5.id
)