# frozen_string_literal: true

module Screenings
  module UseCases
    class RenderSeats
      attr_reader :screening

      def initialize(screening:)
        @screening = screening
      end

      def call
        {
          taken: taken_seats,
          available: available_seats,
        }
      end

      private

      def repository
        Screenings::Repository.new
      end

      def available_seats
        repository.available_seats(screening)
      end

      def taken_seats
        repository.taken_seats(screening)
      end
    end
  end
end
