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

      def available_seats
        Repository.new.available_seats(screening)
      end

      def taken_seats
        Repository.new.taken_seats(screening)
      end
    end
  end
end
