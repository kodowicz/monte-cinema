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
          genre: movie.genre,
          duration: movie.duration,
          age_restriction: movie.age_restriction
        }
      end

      def extended
        {
          **basic,
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
