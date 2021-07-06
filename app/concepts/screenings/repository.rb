# frozen_string_literal: true

module Screenings
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Screening)
      super(adapter: adapter)
    end

    def find_for_movie(movie_id)
      adapter.where(movie_id: movie_id)
    end

    def available_seats(screening)
      all_seats = screening.cinema_hall.seats.flatten
      taken_seats = taken_seats(screening)

      all_seats - taken_seats
    end

    def taken_seats(screening)
      sold_seats = screening.reservations.flat_map(&:tickets).map(&:seat)
      not_available = screening.cinema_hall.not_available

      sold_seats + not_available
    end
  end
end
