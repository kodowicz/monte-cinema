# frozen_string_literal: true

module Movies
  module Representers
    class Pagination
      include Pagy::Backend

      attr_reader :movies

      def initialize(movies:, pagination:)
        @movies = movies.includes(:screenings, :genre)
        @pagy, @movies = pagy(
          @movies,
          page: pagination[:page],
          items: pagination[:items],
        )
      end

      def basic
        {
          info: info,
          movies: movies.map do |movie|
            Single.new(movie).basic
          end,
        }
      end

      def extended
        {
          info: info,
          movies: movies.map do |movie|
            Single.new(movie).extended
          end,
        }
      end

      private

      def info
        {
          current: @pagy.page,
          prev: @pagy.prev,
          next: @pagy.next,
          last: @pagy.last,
        }
      end
    end
  end
end
