# frozen_string_literal: true

module Movies
  module Representers
    class All
      attr_reader :movies

      def initialize(movies)
        @movies = movies.includes(:screenings)
      end

      def basic
        movies.map do |movie|
          Single.new(movie).basic
        end
      end

      def extended
        movies.map do |movie|
          Single.new(movie).extended
        end
      end
    end
  end
end
