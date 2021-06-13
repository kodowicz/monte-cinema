# frozen_string_literal: true

module Movies
  module Representers
    class Single
      attr_reader :movie

      def initialize(movie)
        @movie = movie
      end

      def basic
        {
          id: movie.id,
          title: movie.title,
          genre: movie.genre.name,
          duration: movie.duration,
          age_restriction: movie.age_restriction,
          poster: movie.poster
        }
      end

      def extended
        {
          **basic,
          trailer: movie.trailer,
          production: movie.production,
          description: movie.description,
          screenings: screenings
        }
      end

      private

      def screenings
        @screenings ||= Screenings::Representers::All.new(movie.screenings).basic
      end
    end
  end
end
