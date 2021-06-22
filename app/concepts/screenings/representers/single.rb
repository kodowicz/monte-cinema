# frozen_string_literal: true

module Screenings
  module Representers
    class Single
      attr_reader :screening

      def initialize(screening)
        @screening = screening
      end

      def basic
        {
          id: screening.id,
          starts_at: format_date,
          cinema_hall_id: screening.cinema_hall_id,
          movie_id: screening.movie_id
        }
      end

      def extended
        {
          **basic,
          seats: seats
        }
      end

      private

      def seats
        Screenings::UseCases::RenderSeats.new(screening: screening).call
      end

      def format_date
        screening.starts_at.strftime("%I:%M %p, %d.%m.%Y")
      end
    end
  end
end
